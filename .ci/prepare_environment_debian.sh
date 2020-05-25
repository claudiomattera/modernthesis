#!/bin/sh

set -eu

# Install dependencies
apt-get update
apt-get install -y perl wget gzip tar fontconfig python3-pygments libncurses5

# Install fonts
mkdir ~/.fonts/
find ./fonts/ \( -iname "*.ttf" -or -iname "*.otf" \) -exec cp '{}' ~/.fonts/ \;

# Install TeX Live (skip if already installed)
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz --output-document=/tmp/install-tl-unx.tar.gz
tar xpf /tmp/install-tl-unx.tar.gz -C /tmp
/tmp/install-tl-*/install-tl --profile .ci/texlive-debian.profile
export PATH=/opt/texlive/2020/bin/x86_64-linux/:${PATH}

# Install LaTeX dependencies (skip if using a full TeX Live installation)
tlmgr install `cat .ci/dependencies.txt`
