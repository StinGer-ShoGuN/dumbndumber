# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit multilib qt4-r2

DESCRIPTION="./configure like generator for qmake-based projects"
HOMEPAGE="http://delta.affinix.com/qconf/"
SRC_URI="http://delta.affinix.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="qt5"

DEPEND="!qt5? ( dev-qt/qtcore:4 )
        qt5?  ( dev-qt/qtcore:5 )"
RDEPEND="${DEPEND}"

src_configure() {
	# QT version selection.
	if use qt5; then
		qtdir="qt5"
		qtselect=5
	else
		qtdir="qt4"
		qtselect=4
	fi
	# Fake ./configure. Fails on unknown options
	./configure \
		--prefix=/usr/ \
		--qtdir=/usr/$(get_libdir)/${qtdir}/ \
		--qtselect=${qtselect} || die "./configure failed"

	[ ! -f Makefile ] && die "./configure failed"

	if use qt5; then
		eqmake5
	else
		eqmake4
	fi
}

src_install() {
	dobin qconf || die
	mv ${WORKDIR}/${P}/README.md ${WORKDIR}/${PF}/README
	dodoc README TODO || die
	insinto /usr/share/${PN}
	doins -r conf modules
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
