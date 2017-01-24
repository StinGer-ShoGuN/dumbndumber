# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt application for getting screenshots"
HOMEPAGE="http://screengrab.doomer.org"
SRC_URI="https://github.com/QtDesktop/screengrab/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="dbus upload"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
"
DEPEND="
	${DEPEND}
	>=dev-libs/libqtxdg-2.0.0
	>=dev-util/cmake-2.8.11
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX=/usr
		-DSG_DOCDIR=${PF}
		-DSG_USE_SYSTEM_QXT=OFF
	)
	if use dbus ; then
		mycmakeargs+=(
			-DSG_DBUS_NOTIFY=ON
		)
	else
		mycmakeargs+=(
			-DSG_DBUS_NOTIFY=OFF
		)
	fi
	if use upload ; then
		mycmakeargs+=(
			-DSG_EXT_UPLOADS=ON
		)
	else
		mycmakeargs+=(
			-DSG_EXT_UPLOADS=OFF
		)
	fi

	cmake-utils_src_configure
}
