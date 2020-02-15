FROM scratch
COPY ./server /server
COPY ./public /public
ARG port=12345
LABEL tech.tams.dns_hosts="crystalbyexample.tams.tech cbe.tams.tech crystalbyexample.madscientists.co cbe.madscientists.co" \
      tech.tams.nginx-config.domains="crystalbyexample.tams.tech cbe.tams.tech crystalbyexample.madscientists.co cbe.madscientists.co" \
      tech.tams.nginx-config.destination.port=12345
EXPOSE ${port}
CMD ["/server", "--parent", "/public"]

