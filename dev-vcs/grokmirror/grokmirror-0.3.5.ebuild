# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Smartly mirror git repositories that use grokmirror"
HOMEPAGE="https://www.kernel.org/pub/software/network/grokmirror"
SRC_URI="https://github.com/mricon/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DOCS="README.rst"

PYTHON_COMPAT=( python{2_6,2_7} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

RDEPEND="dev-python/anyjson[${PYTHON_USEDEP}]
	dev-vcs/git
	dev-python/git-python[${PYTHON_USEDEP}]"
DEPEND="${RDEPEDN}"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# Edit grokmirror script files to use python2 symlink.
	local groks_bin="grok-dumb-pull.py grok-fsck.py grok-manifest.py grok-pull.py"
	einfo "Editing grokmirror script files to use python2"
	for script in $groks_bin; do
		sed -i '1 s/^\#\!\/usr\/bin\/python/\#\1\/usr\/bin\/python2/' ${WORKDIR}/${PF}/$script
	done
}
# 
# python_compile() {
# 	distutils-r1_python_compile
# }


python_install() {
 	distutils-r1_python_install
# 		--system-prefix="${EPREFIX}/usr" \
# 		--bindir="$(python_get_scriptdir)" \
# 		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
# 		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
# 		--sbindir="$(python_get_scriptdir)" \
# 		--sysconfdir="${EPREFIX}/etc" \
# 		"${@}"
	# Copy grokmirror script files to ${EPREFIX}/usr/bin.
	local local groks_bin="grok-dumb-pull.py grok-fsck.py grok-manifest.py grok-pull.py"
	exeinto ${EPREFIX}/usr/bin/
	for script in $groks_bin; do
		einfo "Copying $script to /usr/bin/$script"
		newexe ${WORKDIR}/${PF}/$script ${script%%.py}
	done
	# Install repos.conf to /etc/grokmirrors.conf.
	insinto ${EPREFIX}/etc/
	newins ${WORKDIR}/${PF}/repos.conf grokmirrors.conf
	chown git ${WORKDIR}/${PF}/grokmirrors.conf
}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinnst() {
	ewarn "grokmirror has been installed but not tested"
	ewarn "you should check it does work as expected"
}
