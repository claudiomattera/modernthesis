#!/bin/sh

set -eu

# Install dependencies
apk update
apk add perl wget gzip tar fontconfig py3-pygments

# Install fonts
mkdir ~/.fonts/
find ./fonts/ \( -iname "*.ttf" -or -iname "*.otf" \) -exec cp '{}' ~/.fonts/ \;

# Install TeX Live (skip if already installed)
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz --output-document=/tmp/install-tl-unx.tar.gz
tar xpf /tmp/install-tl-unx.tar.gz -C /tmp
/tmp/install-tl-*/install-tl --profile .ci/texlive-alpine.profile
export PATH=/opt/texlive/2020/bin/x86_64-linuxmusl/:${PATH}

# Install LaTeX dependencies (skip if using a full TeX Live installation)
tlmgr install `cat .ci/dependencies.txt`


# Manually compile xindy
#
# This is only necessary on Alpine (or other distributions using musl libc),
# since xindy is not (yet) packaged for those platforms.
# This is irrelevant anywhere else (regular Linux distributions or Windows).
#
# More information here:
# http://ftp.math.utah.edu/pub/texlive-utah/README.html
# and here:
# http://www.linuxfromscratch.org/blfs/view/8.3/pst/xindy.html
apk add make musl-dev gcc
apk add clisp --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
wget http://mirrors.ctan.org/indexing/xindy/base/xindy-2.5.1.tar.gz --output-document=/tmp/xindy-2.5.1.tar.gz
tar xpf /tmp/xindy-2.5.1.tar.gz -C /tmp
cp .ci/xindy-2.5.1-upstream_fixes-1.patch /tmp/xindy-2.5.1/
cd /tmp/xindy-2.5.1
export TEXARCH=x86_64-linuxmusl
sed -i "s/ grep -v '^;'/ awk NF/" make-rules/inputenc/Makefile.in
sed -i 's%\(indexentry\)%\1\\%' make-rules/inputenc/make-inp-rules.pl
patch -Np1 -i ./xindy-2.5.1-upstream_fixes-1.patch
./configure --prefix=/opt/texlive/2020              \
            --bindir=/opt/texlive/2020/bin/$TEXARCH \
            --datarootdir=/opt/texlive/2020         \
            --includedir=/usr/include               \
            --libdir=/opt/texlive/2020/texmf-dist   \
            --mandir=/opt/texlive/2020/texmf-dist/doc/man
tlmgr install cyrillic
make LC_ALL=POSIX
make install
cd -
