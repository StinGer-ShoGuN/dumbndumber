# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} pypy )

inherit distutils-r1

DESCRIPTION="Python Serial Port Extension"
HOMEPAGE="https://github.com/pyserial/pyserial https://pypi.python.org/pypi/pyserial"
SRC_URI="https://github.com/pyserial/pyserial/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc examples"

DEPEND="
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

# Usual avoid d'loading un-needed objects.inv file
PATCHES=( "${FILESDIR}"/pyserial-3.1-mapping.patch )

DOCS=( CHANGES.rst README.rst )

python_compile_all() {
	use doc && emake -C documentation html
}

python_install_all() {
	use doc && local HTML_DOCS=( documentation/_build/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
