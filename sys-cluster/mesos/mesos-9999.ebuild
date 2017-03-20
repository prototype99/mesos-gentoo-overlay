# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-2 autotools

EGIT_REPO_URI="git://git.apache.org/mesos.git"

DESCRIPTION="a cluster manager that provides efficient resource isolation and sharing across distributed applications"
HOMEPAGE="http://mesos.apache.org/"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="network-isolator perftools"
SLOT="0"

DEPEND="dev-cpp/glog
        net-libs/http-parser
        net-misc/curl
        dev-cpp/picojson
        dev-libs/cyrus-sasl[ssl]
        dev-libs/apr
        dev-libs/libev
        dev-libs/leveldb
        dev-libs/protobuf
        dev-vcs/subversion
        network-isolator? ( dev-libs/libnl )"

S="${WORKDIR}/${P}"

src_prepare() {
        eautoreconf
}

src_configure() {
        # See https://www.mail-archive.com/user@mesos.apache.org/msg04222.html
        export SASL_PATH=/build/amd64-usr/usr/lib/sasl2
        export LD_LIBRARY_PATH=/build/amd64-usr/usr/lib:$LD_LIBRARY_PATH
        use network-isolator perftools
	# default is x86_64-pc-linux-gnu and x86_64-cross-linux-gnu... which counts as cross-compiling
	# then ./configure will fail
        econf --build=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu \
                $(use_enable perftools) \
                $(use_with network-isolator) \
                --disable-python \
                --disable-java \
                --enable-optimize \
                --with-protobuf=/build/amd64-usr/usr \
                --with-leveldb=/build/amd64-usr/usr \
                --with-glog=/build/amd64-usr/usr \
                --with-apr=/build/amd64-usr/usr \
                --with-svn=/build/amd64-usr/usr \
                --with-sasl=/build/amd64-usr/usr \
                --with-picojson=/build/amd64-usr/usr \
                --with-nl=/build/amd64-usr/usr \
                --with-http-parser=/build/amd64-usr/usr \
                --with-libev=/build/amd64-usr/usr
}

src_compile() {
        emake
}

src_install() {
        emake DESTDIR="${D}" install
}

