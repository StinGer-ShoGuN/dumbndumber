# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils git-r3

DESCRIPTION="Repository tool for multi-repository management"
HOMEPAGE="http://gitslave.sf.net"
SRC_URI=""
EGIT_REPO_URI="git://git.code.sf.net/p/gitslave/code"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="progressbar parallel"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	>=dev-vcs/git-1.6
	progressbar? ( dev-perl/Term-ProgressBar )
	parallel? ( dev-perl/Parallel-Iterator )"

src_prepare() {
	# Fix regular expression special char escapes.
	epatch "${FILESDIR}/${P}-regexp.patch"
	# pod2man fix for generating manuals.
	epatch "${FILESDIR}/${P}-mk_pod2man.patch"
	eapply_user
}

src_compile() {
	emake prefix=/usr || die
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr "$@" install || die "died running make install, $FUNCNAME"
	dodoc README LICENSE.TXT LICENSE.README ReleaseNotes
}
