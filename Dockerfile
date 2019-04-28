FROM cran/debian

VOLUME /data

ADD setup.R /tmp/setup.R
RUN Rscript /tmp/setup.R

ADD build.R /build.R
ADD deploy.R /deploy.R
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
