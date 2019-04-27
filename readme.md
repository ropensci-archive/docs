# rOpenSci docs [![badge](https://images.microbadger.com/badges/image/ropensci/docs.svg)](https://cloud.docker.com/u/ropensci/repository/docker/ropensci/docs/general)

Tooling to generate pkgdown sites and more.

## Create a Volume

First create a persistent volume `data` which will hold the websites and source packages:

```
docker volume create data
```

Then use any standard webserver container to host the `data` volume:

```
docker run -d -p 80:8043 -v data:/srv/http --name httpd pierrezemb/gostatic
```

Now navigate to http://localhost in your browser. Use `docker stop` and `docker start` to pause and restart the webserver:

```
docker stop httpd
```

The `data` volume persists after killing or restarting webserver.


## Building and host locally

Build packages from their git url using the `ropensci/docs` image. These may run in parallel:

``` 
docker run --rm -it -v data:/data ropensci/docs https://github.com/jeroen/openssl
docker run --rm -it -v data:/data ropensci/docs https://github.com/ropensci/magick
docker run --rm -it -v data:/data ropensci/docs https://github.com/ropensci/tesseract
```

Upon success, the websites will be available in http://localhost/docs

## Build and deploy to Github

To also deploy to Github you need to provide a `GITHUB_PAT` variable with permission to your Github org. Then just append a asecond argument to the docker command with the organization name to deploy:

```
docker run --rm -it --env-file=env.txt -v data:/data ropensci/docs https://github.com/ropensci/magick ropensci-docs
```

## Cleanup

Stop the webserver (if any) and remove the `data` volume:

```
docker stop httpd && docker rm httpd
docker volume rm data
```
