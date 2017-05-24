# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Repository tool for multi-repository management"
HOMEPAGE="http://gitslave.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="progressbar parallel"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	>=dev-vcs/git-1.6
	progressbar? ( dev-perl/Term-ProgressBar )
	parallel? ( dev-perl/Parallel-Iterator )"

src_compile() {
	emake prefix=/usr || die
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr "$@" install || die "died running make install, $FUNCNAME"
	dodoc README LICENSE.TXT LICENSE.README ReleaseNotes
}
