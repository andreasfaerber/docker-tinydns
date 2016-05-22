# docker-tinydns
Docker image running tinydns and axfrdns as name server

Name server in a docker container running tinydns and axfrdns. Uses
a git repository to periodically pull and update the DNS data.

### Example usages

Create base axfrdns_tcp file:

```
cat > axfrdns_tcp <<EOF
# sample line:  1.2.3.4:allow,AXFR="heaven.af.mil/3.2.1.in-addr.arpa"
127.0.0.1:allow
:allow,AXFR=""
EOF
```

Run tinydns docker container with example data:

```
docker run -d \
           -e GIT_DNSDATA="https://github.com/andreasfaerber/docker-tinydns-exampledata.git" \
           -e GIT_UPDATE_FREQUENCY=60 \
           -v /docker-tinydns/axfrdns_tcp:/etc/axfrdns/tcp \
           -p 53:53/udp -p 53:53/tcp \
           --name tinydns_example \
           afaerber/docker-tinydns
```

Run with ssh key authentication for some real world DNS data repository:

- Create a SSH key pair required to pull your DNS data (named ssh_key and ssh_key.pub here)
- Allow the repository to be pulled by that SSH key pair (read-only)
- Change the example GIT_DNSDATA URL to your DNS data repository

```
docker run -d \
           -e GIT_DNSDATA="https://github.com/andreasfaerber/docker-tinydns-exampledata.git" \
           -e GIT_UPDATE_FREQUENCY=60 \
           -v /docker-tinydns/ssh_key:/root/.ssh/id_rsa \
           -v /docker-tinydns/ssh_key.pub:/root/.ssh/id_rsa.pub \
           -v /docker-tinydns/axfrdns_tcp:/etc/axfrdns/tcp \
           -p 53:53/udp -p 53:53/tcp \
           --name tinydns_example \
           afaerber/docker-tinydns
```

