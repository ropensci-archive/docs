## Create a Volume

First create a persistent volume that will hold the websites and source packages

```
docker volume create data
```

## Building packages

Build packages from their git url. This can be done in parallel:

``` 
docker run -i -t -v data:/data ropensci/docs https://github.com/jeroen/openssl
docker run -i -t -v data:/data ropensci/docs https://github.com/ropensci/magick
docker run -i -t -v data:/data ropensci/docs https://github.com/ropensci/tesseract
```

## Hosting a web server

Then inspect the websites, start any webserver to host the volume:

```
docker run -d -p 80:8043 -v data:/srv/http --name httpd pierrezemb/gostatic
```

Check http://localhost to show the contents. The data volume persists after killing or restarting webserver.

## Deploying

