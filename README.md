# Minified React App Nginx

Minifying a react app and running the minimal build to be served by nginx docker container

## Multi-stage dockerfile
In the first stage `react_build`, that's where all the heavy building of the app is happening, which ends with a production levl build folder. In stage 2 `web_server`, I copied the build folder from **react_build** into this stage to be served by the `Nginx` container.

I reduced the final image by 88%. The original **react_build image** image size was 775.3 mb but the final **web_server image** with nginx installed was 94.16 mb.

## Nginx Configuration
I deleted the default nginx configuration in the Nginx container and replaced it with a new one that serves the react website i copied through the build files.
```bash
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html/build;
        index  index.html index.htm;
    }

    # redirect server error pages to the static page /50x.html
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

I finally pushed my minified web server image to docker hub:
```bash
docker push rocketman02/mini_react_web:v1
```

You can view the image [here](https://hub.docker.com/repository/docker/rocketman02/mini_react_web/general)