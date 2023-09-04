# Home Lab #

## Network ##

All containers in the `docker-compose.yml` file would share the same network. All the containers are addressible by the `container_name` hostname as it appears in the docker compose configuration file.

## DNS Resolution ##

[Pihole](https://pi-hole.net/)

In `etc/resolv.conf` on the host machine, add an additional nameserver pointing to `127.0.0.1`

```
nameserver 127.0.0.1 #pihole
nameserver 8.8.8.8
```

- By default, pihole will be consulted as the dns for your system. If it fails, then your default nameservers will be used.
- For the docker containers, pihole will still be used as a dns solution because by default the host system's dns resolver is used.
- Under `Local DNS` setup a DNS pointing to `127.0.0.1` for `home`.
- For every service that needs to be exposed, create a CNAME record, pointing to `home`. Example, create a CNAME `draw.home` pointing to `home`, and configure proxy pass for the port `5000` of the docker host `excalidraw` for the domain `draw.home` in nginx. Do not use `home` subdomains inside nginx or any docker container as it would always resolve to localhost.

Note the `CORS_HOSTS` mapping in the docker compose configuration. This should point to the 
The DNS and CNAME configurations are present inside the `pihole` folder. Update it and restart the `pihole` service using `restartService.sh pihole`.

## Nginx Reverse proxy ##

[Nginx](https://nginx.org/en/)

#### Self signed certificate ####

- Create and install a self signed certificate on the nginx container. The public key of this certificate should be installed by the hosts using the homelab.
- To generate the certs, run the `createCerts.sh`. Note that this is mounted on to the nginx container.
- To install the certs, run `sudo trust anchor --store cert.crt`
- May need to still accept promts the first time this is accessed from the browser.
- To remove, `sudo trust anchor --remove cert.crt`. Alternatively, remove it from `/etc/ca-certificates/trust-source/`

The NGINX configurations are present inside the `pihole` folder. Update it and restart the `nginx` service using `restartService.sh nginx`.

## All app configurations ##

| App                                          | Url                    | Description      |
|----------------------------------------------|------------------------|------------------|
| [Flame](https://github.com/pawelmalak/flame) | https://dash.home      | Dashboard        |
| [Pihole](https://pi-hole.net/)               | https://dns.home/admin | DNS Management   |
| [Excalidraw](https://excalidraw.com)         | https://draw.home      | Diagramming tool |

## TODOS ##

- [ ] Autoconfiguration of dashboard
- [ ] Media streaming - CalibreWeb, sonarr, radarr, jackett etc
- [ ] Storage server
- [ ] Monitoring
- [ ] Genealogy
- [ ] Password manager
- [ ] Note taking
- [ ] Photos
- [ ] Blog server


