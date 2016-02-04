### Nginx compiling 

- Add modules to your rules file, for example `/opt/rebuildnginx/nginx-1.8.1/debian/rules`

```
--add-module=/opt/upload-progress-module/nginx-upload-progress-module-master
--add-module=/opt/upload-module/nginx-upload-module-2.2
```

- Run nginx building 
```
cd /opt/rebuildnginx/nginx-1.8.1
dpkg-buildpackage -b
```