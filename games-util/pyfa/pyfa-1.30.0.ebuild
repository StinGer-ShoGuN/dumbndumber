# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,threads"

inherit eutils gnome2-utils python-single-r1

DESCRIPTION="Python Fitting Assistant - a ship fitting application for EVE Online"
HOMEPAGE="https://github.com/pyfa-org/Pyfa"

LICENSE="GPL-3+"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/pyfa-org/Pyfa.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="https://github.com/pyfa-org/Pyfa/archive/v${PV}.tar.gz -> pyfa-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

IUSE="+graph"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-0.6[${PYTHON_USEDEP}]
	>=dev-python/wxpython-2.8[${PYTHON_USEDEP}]
	>=dev-python/logbook-0.10.0[${PYTHON_USEDEP}]
	graph? (
	dev-python/matplotlib[wxwidgets,${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"
DEPEND="${PYTHON_DEPS}
		${RDEPEND}"

S=${WORKDIR}/Pyfa-${PV}

src_prepare() {
	# get rid of CRLF line endings introduced in 1.1.10 so patches work
	edos2unix config.py pyfa.py service/settings.py

	# fix import path in the main script for systemwide installation
	epatch "${FILESDIR}/${PN}-1.30.0-import-pyfa.patch"

	# fix root path for systemwide installation
	epatch "${FILESDIR}/${PN}-1.30.0-root-path.patch"

	# run with python2
	sed -e "s:\(/usr/bin/env \)python$:\\1python2:" -i pyfa.py

	pyfa_make_configforced() {
		mkdir -p "${S}" || die
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			-e "s:%%EPREFIX%%:${EPREFIX}:" \
			"${FILESDIR}/configforced.py" > "configforced.py"
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			-i config.py
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			pyfa.py > pyfa
	}
	pyfa_make_configforced
}

src_install() {
	pyfa_py_install() {
		local packagedir=$(python_get_sitedir)/${PN}
		insinto "${packagedir}"
		doins -r eos gui imgs service utils LICENSE
		[[ -e info.py ]] && doins info.py # only in zip releases
		doins "configforced.py" "config.py"
		python_doscript "pyfa"
		python_optimize
	}
	pyfa_py_install

	insinto /usr/share/${PN}
	doins eve.db
	dodoc README.md
	insinto /usr/share/icons/hicolor/32x32/apps
	doins imgs/gui/pyfa.png
	insinto /usr/share/icons/hicolor/64x64/apps
	newins imgs/gui/pyfa64.png pyfa.png
	domenu "${FILESDIR}/${PN}.desktop"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
