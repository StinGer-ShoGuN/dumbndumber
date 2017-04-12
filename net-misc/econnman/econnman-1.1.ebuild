# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="ConnMan User Interface in EFL"
HOMEPAGE="https://git.enlightenment.org/apps/${PN}.git/about/"
SRC_URI="https://download.enlightenment.org/rel/apps/${PN}/${P}.tar.gz"

PYTHON_COMPAT=( python2_7 )

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="( >=dev-libs/efl-1.18.4 )"
RDEPEND="${DEPEND}"
