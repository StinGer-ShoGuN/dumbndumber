# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VERSION="0.2.1"
DESCRIPTION="Rage is a video and audio player written with Enlightenment Foundation Libraries with some extra bells and whistles."
HOMEPAGE="https://www.enlightenment.org/about-rage"
SRC_URI="https://download.enlightenment.org/rel/apps/rage/rage-${VERSION}.tar.gz"

LICENSE="BSD2Clause"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/efl"
RDEPEND="${DEPEND}"
