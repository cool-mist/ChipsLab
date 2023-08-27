# Home Lab #

## Pihole ##

In `etc/resolv.conf` on the host machine, add additional nameserver pointing to `127.0.0.1`

```
nameserver 127.0.0.1 #pihole
nameserver 8.8.8.8
```

Hostport - 8053
Dockerport - 80
Admin UI - localhost:8053/admin
DNS - dns.home.lan

- By default, pihole will be consulted as the dns for your system. If it fails, then your default nameservers will be used.
- For the docker containers, pihole will still be used as a dns solution because by default the host system's dns resolver is used.
- Under `Local DNS` setup a DNS pointing to `127.0.0.1` for `home.lan`.
- For every service that needs to be exposed, create a CNAME record, pointing to `home.lan`. Example, create a CNAME `draw.home.lan` pointing to `home.lan`, and configure the port `5000` of `excalidraw` for the domain `draw.home.lan` in nginx. Do not use `home.lan` subdomains inside nginx or any docker container as it would always resolve to localhost.

TODO: While using nginx https, CNAME records do not populate on the UI, need to directly use `http://localhost:8053/admin`. Till then this additional mapping cannot be removed.

## Nginx ##

#### Self signed certificate ####

- Create and install a self signed certificate on the nginx container. The public key of this certificate should be installed by the hosts using the homelab.
- To generate the certs, run the `createCerts.sh`. Note that this is mounted on to the nginx container.
- To install the certs, run `sudo trust anchor --store cert.crt`
- May need to still accept promts the first time this is accessed from the browser.
- To remove, `sudo trust anchor --remove cert.crt`. Alternatively, remove it from `/etc/ca-certificates/trust-source/`

## All app configurations ##

App | Url
-|-
PiHole|https://dns.home/admin
excalidraw|https://draw.home

