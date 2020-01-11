FROM scratch
COPY ./server /server
COPY ./public /public
ARG port=12345
LABEL traefik.enable="true" \
    traefik.http.routers.crystalbyexample.tls="true" \
    traefik.http.routers.crystalbyexample.tls.certresolver="letsencrypt" \
    traefik.http.routers.crystalbyexample.rule="Host(`crystalbyexample.tams.tech`,`crystalbyexample.madscientists.co`)" \
    traefik.http.services.crystalbyexample.loadbalancer.server.port=${port} \
    tech.tams.dns_hosts="crystalbyexample.tams.tech crystalbyexample.madscientists.co"
EXPOSE ${port}
CMD ["/server", "--parent", "/public"]


# traefik.enable: "true"
# traefik.http.routers.bitwarden.tls: 'true'
# traefik.http.routers.bitwarden.tls.certresolver: letsencrypt
# traefik.http.routers.bitwarden.rule: Host(`pw.tams.tech`,`pw.madscientists.co`,`bitwarden.tams.tech`,`bitwarden.madscientists.co`)
# tech.tams.dns_hosts: pw.tams.tech pw.madscientists.co bitwarden.tams.tech bitwarden.madscientists.co

