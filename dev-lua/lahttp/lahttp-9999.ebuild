# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from Lua overlay; Bumped by mva; $

EAPI="4"

inherit multilib toolchain-funcs flag-o-matic mercurial eutils

DESCRIPTION="Lua Asynchronous HTTP Library."
HOMEPAGE="http://code.mathewwild.co.uk/"
EHG_REPO_URI="http://code.matthewwild.co.uk/${PN}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="|| ( >=dev-lang/lua-5.1 dev-lang/luajit:2 )
	dev-lua/squish
	dev-lua/luasocket"
DEPEND="${RDEPEND}"

src_compile() {
	squish --use-http
}

src_install() {
	insinto $($(tc-getPKG_CONFIG) --variable INSTALL_LMOD lua)
	doins lahttp.lua || die
}
