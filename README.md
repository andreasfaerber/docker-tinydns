# docker-tinydns
Docker image running tinydns and axfrdns as name server

Name server in a docker container running tinydns and axfrdns. Uses
a git repository to periodically pull and update the DNS data.

### Usage

Run with example data:

```
docker run -d \
           -e GIT_DNSDATA="https://github.com/andreasfaerber/docker-tinydns-exampledata.git" \
           -e GIT_UPDATE_FREQUENCY=60 \
           -v /docker-tinydns/axfrdns_tcp:/etc/axfrdns/tcp \
           -p 53:53/udp -p 53:53/tcp \
           --name tinydns_example \
           afaerber/docker-tinydns
```
