import sys, getopt


def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hi:", ["ifile="])
        for opt, arg in opts:
            if opt in ("-i", "--ifile"):
                filename = str(arg).strip()
                if len(filename) > 0:
                    add_modules(filename)
                    sys.exit()
    except getopt.GetoptError:
        pass

    print('configure.py -i <inputfile>')
    sys.exit(2)


def add_modules(filename):
    with open(filename) as f:
        lines = f.readlines()

    found = False
    for index, line in enumerate(lines):
        if not found:
            if line.find("full_configure_flags") >= 0:
                found = True
        else:
            if line.strip().__len__() == 0:
                break
    lines[index - 1] = lines[index - 1].replace("\n", " \\\n")
    lines.insert(index, "\t\t\t--add-module=/opt/upload-progress-module/nginx-upload-progress-module-master \\\n")
    lines.insert(index + 1, "\t\t\t--add-module=/opt/upload-module/nginx-upload-module-2.2 \n")

    with open(filename, 'w') as f:
        f.writelines(lines)


if __name__ == "__main__":
    main(sys.argv[1:])
