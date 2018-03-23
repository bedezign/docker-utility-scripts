#/usr/bin/env sh

echo '*** Installing docker-machine'
curl -L https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
  chmod +x /tmp/docker-machine &&
  cp /tmp/docker-machine /usr/local/bin/docker-machine
