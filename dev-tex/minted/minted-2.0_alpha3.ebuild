# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit latex-package

DESCRIPTION="LaTeX package that facilitates expressive syntax highlighting in using the powerful Pygments library"
HOMEPAGE="https://github.com/gpoore/minted"
SRC_URI="https://github.com/gpoore/minted/archive/v${PV%_alpha*}-alpha3.tar.gz"
RESTRICT="primaryuri"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-texlive/texlive-latexextra
	dev-python/pygments"

S="${WORKDIR}"/

src_install() {
	latex-package_src_install
}
