# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-2 autotools

EGIT_REPO_URI="https://github.com/drcrallen/mesos.git"

DESCRIPTION="a cluster manager that provides efficient resource isolation and sharing across distributed applications"
HOMEPAGE="http://mesos.apache.org/"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="network-isolator perftools"
SLOT="0"

RDEPEND="dev-libs/apr
        net-misc/curl
        dev-cpp/glog
        dev-libs/leveldb
        dev-libs/libev
        network-isolator? ( dev-libs/libnl )
        dev-cpp/picojson
        dev-libs/protobuf
        dev-libs/cyrus-sasl
        dev-vcs/subversion"
DEPEND=$RDEPEND
S="${WORKDIR}/${P}"

src_prepare() {
        eautoreconf
}

src_configure() {
        # See https://www.mail-archive.com/user@mesos.apache.org/msg04222.html
        export SASL_PATH=/build/amd64-usr/usr/lib/sasl2
        export LD_LIBRARY_PATH=/build/amd64-usr/usr/lib:$LD_LIBRARY_PATH
        econf --build=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu \
                $(use_enable perftools) \
                $(use_with network-isolator) \
                --disable-python \
                --disable-java \
                --enable-optimize \
                --with-apr=/build/amd64-usr/usr \
                --with-curl=/build/amd64-usr/usr \
                --with-glog=/build/amd64-usr/usr \
                --with-libev=/build/amd64-usr/usr \
                --with-leveldb=/build/amd64-usr/usr \
                --with-nl=/build/amd64-usr/usr \
                --with-picojson=/build/amd64-usr/usr \
                --with-protobuf=/build/amd64-usr/usr \
                --with-sasl=/build/amd64-usr/usr \
                --with-svn=/build/amd64-usr/usr
}

src_compile() {
        emake
}

src_test() {
        emake check
}

src_install() {
        emake DESTDIR="${D}" install
}

