# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="a cluster manager that provides efficient resource isolation and sharing across distributed applications"
HOMEPAGE="http://mesos.apache.org/"
SRC_URI="http://archive.apache.org/dist/${PN}/${PV}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
IUSE="java python network-isolator perftools"
SLOT="0"

DEPEND="dev-cpp/glog
	dev-java/maven-bin
	net-misc/curl
	dev-libs/cyrus-sasl
	dev-libs/apr
	dev-libs/leveldb
	sys-cluster/zookeeper
	dev-vcs/subversion
	>=dev-libs/protobuf-2.5.0[java,python]
	python? ( dev-lang/python dev-python/boto )
	java? ( virtual/jdk )
	network-isolator? ( >=dev-libs/libnl-3.2.28 )"

S="${WORKDIR}/${P}"

src_configure() {
	export PROTOBUF_JAR=/usr/share/protobuf/lib/protobuf.jar
	econf $(use_enable python) $(use_enable java) $(use_enable perftools) \
		$(with_enable network-isolator) \
		--enable-optimize \
		--with-protobuf=/usr \
		--with-leveldb=/usr \
		--with-zookeeper=/usr \
		--with-glog=/usr \
		--with-apr=/usr \
		--with-svn=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
