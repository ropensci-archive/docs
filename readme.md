# rOpenSci docs [![badge](https://images.microbadger.com/badges/image/ropensci/docs.svg)](https://cloud.docker.com/u/ropensci/repository/docker/ropensci/docs/general)

Tooling to generate pkgdown sites and more.

## Create a Volume

First create a persistent volume that will hold the websites and source packages

```
docker volume create data
```

## Building packages

Build packages from their git url using the `ropensci/docs` image. This may be done in parallel:

``` 
docker run -i -t -v data:/data ropensci/docs https://github.com/jeroen/openssl
docker run -i -t -v data:/data ropensci/docs https://github.com/ropensci/magick
docker run -i -t -v data:/data ropensci/docs https://github.com/ropensci/tesseract
```

## Hosting a web server

Then inspect the websites, use any webserver container to host the volume:

```
docker run -d -p 80:8043 -v data:/srv/http --name httpd pierrezemb/gostatic
```

Now just navigate to http://localhost in your browser. To kill the webserver:

```
docker stop httpd
```

The data volume persists after killing or restarting webserver.

## Deployment
