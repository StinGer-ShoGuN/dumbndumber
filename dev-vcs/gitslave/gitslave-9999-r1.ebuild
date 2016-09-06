# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Repository tool for multi-repository management"
HOMEPAGE="http://gitslave.sf.net"
SRC_URI=""
EGIT_REPO_URI="git://git.code.sf.net/p/gitslave/code"

LICENSE="LGPL-2.1-fixed"
SLOT="0"
KEYWORDS=""
IUSE="progressbar parallel"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND} 
	>=dev-vcs/git-1.6
	progressbar? ( dev-perl/Term-ProgressBar )
	parallel? ( dev-perl/Parallel-Iterator )"

src_prepare() {
	epatch "${WORKDIR}/001-e69165a.patch"
}

src_compile() {
	emake prefix=/usr || die
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr "$@" install || die "died running make install, $FUNCNAME"
	dodoc README LICENSE.TXT LICENSE.README ReleaseNotes
}
