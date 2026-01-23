#!/bin/sh
set -e

# Clean up
rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

apt_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Updating th e distribution with apt..."
        apt update -y
    fi
}

# Checks if packages are installed and installs them if not
ensure_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Install dependencies
ensure_packages curl ca-certificates

[ "$VERSION" = "latest" ] && VERSION="$(curl -s https://api.github.com/repos/ionos-cloud/ionosctl/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"

echo "Activating feature 'ionosctl'"
echo "The provided version is: ${VERSION}"

curl -sL https://github.com/ionos-cloud/ionosctl/releases/download/${VERSION}/ionosctl-${VERSION#v}-linux-amd64.tar.gz | tar -xzv &&\
  mv ionosctl /usr/local/bin

chmod +x /usr/local/bin/ionosctl
