# Dynamic DNS updater for the ARM based Raspberry PI.

Get youself a **account at [spDYN](https://www.spdyn.de/)** or similar provider. If you choose a different provider - make sure to read the **Customising section**.

This **images target the ARM architecture**, uses the well known [ddclient](https://www.strongswan.org/) library and is based on [alpine Linux](http://www.alpinelinux.org/), and thus leads to a **slimmer image**.

[![Build Status](https://travis-ci.org/netzfisch/rpi-dyndns.svg?branch=master)](https://travis-ci.org/netzfisch/rpi-dyndns)
[![](https://images.microbadger.com/badges/version/netzfisch/rpi-dyndns.svg)](https://microbadger.com/images/netzfisch/rpi-dyndns "Inspect image") [![](https://images.microbadger.com/badges/image/netzfisch/rpi-dyndns.svg)](https://microbadger.com/images/netzfisch/rpi-dyndns "Inspect image")

Find the source code at [GitHub](https://github.com/netzfisch/rpi-dyndns) or the ready-to-run image in the [DockerHub](https://hub.docker.com/r/netzfisch/rpi-dyndns/) and **do not forget to _star_** the repository ;-)

## Running

Get ready to roll and run the container:

    $ docker run --detach \
                 --name ddclient \
                 --env HOSTNAME=yourdomain.spdns.de \
                 --env UPDATE_TOKEN=imwg-futl-mzmw \
                 --restart unless-stopped \
                 netzfisch/rpi-dyndns

## Customising

To customise change `ddclient.conf` to your needs, e.g. see possible configuration options at this [template file](https://github.com/ddclient/ddclient/blob/master/sample-etc_ddclient.conf). Make sure to use '@@hostname/login/password@@' syntax, otherwise variable replacement will fail!

Than build for yourself and run again:

    $ git clone git@github.com:netzfisch/rpi-dyndns.git && cd rpi-dyndns
    $ docker build -t netzfisch/rpi-dyndns:custom .
    $ docker run ... see above parameters
                 netzfisch/rpi-dyndns:custom

If you just need to **manually setup, start the container without environment parameters** and replace variables with `sed`:

    $ env HOSTNAME=yourdomain.spdns.de LOGIN=yourdomain.spdns.de UPDATE_TOKEN=imwg-futl-mzmw
    $ docker exec ddclient sed -i -e 's/@@hostname@@/$HOSTNAME/g' /etc/ddclient.conf
    $ ...

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
