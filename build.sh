export PREFIX=~/.local
echo "PREFIX = $PREFIX"

export BUILD_DIR=~/homebrew
echo "BUILD_DIR = $BUILD_DIR"
mkdir -p $BUILD_DIR

# autoconf
cd $BUILD_DIR
curl -LO https://ftpmirror.gnu.org/autoconf/autoconf-2.71.tar.xz
rm -fr  autoconf-2.71
tar xzf autoconf-2.71.tar.xz
cd      autoconf-2.71
export PERL=/usr/bin/perl
sed -i '' 's/libtoolize/glibtoolize/g' bin/autoreconf.in
sed -i '' 's/libtoolize/glibtoolize/g' man/autoreconf.1
./configure --prefix=${PREFIX}
make install

# automake
cd $BUILD_DIR
curl -LO https://ftpmirror.gnu.org/automake/automake-1.16.4.tar.xz
rm -fr  automake-1.16.4
tar xzf automake-1.16.4.tar.xz
cd      automake-1.16.4
export PERL=/usr/bin/perl
./configure --prefix=${PREFIX}
make install

# libtool
cd $BUILD_DIR
curl -LO https://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.xz
rm -fr  libtool-2.4.6
tar xzf libtool-2.4.6.tar.xz
cd      libtool-2.4.6
export SED=sed
export PERL=/usr/bin/perl
# this patch appears to break `make install` (errors missing automake-15) 
# curl -LO https://github.com/Homebrew/formula-patches/raw/e5fbd46a25e35663059296833568667c7b572d9a/libtool/dynamic_lookup-11.patch
# patch -p0 <dynamic_lookup-11.patch
./configure \
  --disable-dependency-tracking \
  --prefix=${PREFIX} \
  --program-prefix=g \
  --enable-ltdl-install
make install

# bash 5.1
cd $BUILD_DIR
curl -LO http://git.savannah.gnu.org/cgit/bash.git/snapshot/bash-master.tar.gz
rm -fr  bash-master
tar xzf bash-master.tar.gz
cd      bash-master
./configure --prefix=${PREFIX}
make install

# https://github.com/stedolan/jq
cd $BUILD_DIR
rm -fr jq
git clone git@github.com:stedolan/jq.git
cd jq
git submodule update --init
autoreconf -fi
./configure --with-oniguruma=builtin --disable-maintainer-mode --prefix=${PREFIX}
make install