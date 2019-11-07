FROM rocker/shiny:3.5.3

RUN apt-get update && apt-get install libcurl4-openssl-dev libv8-3.14-dev -y

RUN R -e "install.packages(c('shiny', 'ggplot2', 'scales', 'plyr'))"

COPY shiny-server.conf /etc/shiny-server/

RUN rm -rf /srv/shiny-server/*
COPY resale.R server.R ui.R /srv/shiny-server/resale/
RUN chown shiny:shiny /srv/shiny-server/resale
RUN chmod 755 /srv/shiny-server/resale

EXPOSE 3839

CMD ["/usr/bin/shiny-server.sh"] 
