# rpi-dyndns

Dynamic DNS updater for the ARM based Raspberry PI.

Get youself a **account at [spDYN](https://www.spdyn.de/)** or similar provider. If you choose a different provider - make sure to read the **Customising section.

This **images target the ARM architecture**, uses the well known [ddclient](https://www.strongswan.org/) library and is based on [alpine Linux](http://www.alpinelinux.org/), and thus leads to a **slimmer image**.

[![](https://images.microbadger.com/badges/version/netzfisch/rpi-dyndns.svg)](https://microbadger.com/images/netzfisch/rpi-dyndns "Inspect image") [![](https://images.microbadger.com/badges/image/netzfisch/rpi-dyndns.svg)](https://microbadger.com/images/netzfisch/rpi-dyndns "Inspect image")

Find the source code at [GitHub](https://github.com/netzfisch/rpi-dyndns) or the ready-to-run image in the [DockerHub](https://hub.docker.com/r/netzfisch/rpi-dyndns/) and **do not forget to _star_** the repository ;-)

## Runing

Get ready to roll and run the container:

    $ docker run --detach \
                 --name ddclient \
                 --restart unless-stopped \
                 -e HOSTNAME=netzfisch.spdns.de \
                 -e UPDATE_TOKEN=imwg-futl-mzmw \
                 netzfisch/rpi-dyndns

## Configuring

Than setup the **ddclient** by reading the **credentials from the environment** variables and storing them in the running container:

    $ env docker exec ddclient setup

## Customising

To customise change `ddclient.conf` to your needs, e.g. see following configuration options at https://github.com/ddclient/ddclient/blob/master/sample-etc_ddclient.conf.

Than build for yourself:

    $ docker build -t netzfisch/rpi-dyndns:custom .

## Debugging

Check that the environment includes your credentials:

    $ docker exec -it ddclient env

After running `docker exec ddclient setup` look up, if configuration was set right:

    $ docker exec ddclient cat /etc/ddclient/ddclient.conf

Finally you could dig into the container:

    $ docker exec -it ddclient ash

## Contributing

If you find a problem, please create a [GitHub Issue](https://github.com/netzfisch/rpi-dyndns/issues).

Have a fix, want to add or request a feature? [Pull Requests](https://github.com/netzfisch/rpi-dyndns/pulls) are welcome!

### License

The MIT License (MIT), see [LICENSE](https://github.com/netzfisch/rpi-dyndns/blob/master/LICENSE) file.
