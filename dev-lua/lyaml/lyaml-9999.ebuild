# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from Lua overlay; Bumped by mva; $

EAPI="5"

inherit base toolchain-funcs eutils git-r3

DESCRIPTION="LibYAML binding for Lua."
HOMEPAGE="https://github.com/gvvaughan/lyaml"
SRC_URI=""

EGIT_REPO_URI="https://github.com/gvvaughan/lyaml"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE="luajit"

RDEPEND="
	!luajit? (
		=dev-lang/lua-5.1*
	)
	luajit? ( dev-lang/luajit:2 )
	dev-libs/libyaml
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" "NEWS" )

src_prepare() {
	if [[ -n ${EVCS_OFFLINE} ]]; then
		die "Unfortunately, upstream uses buildsystem which depends on external submodules, so you won't be able to build package in offline mode. Sorry."
	fi

	local lua=lua
	use luajit && lua=luajit
	export LUA="${lua}"

	./bootstrap
}

src_configure() {
	myeconfargs=(
		"--datadir=$($(tc-getPKG_CONFIG) --variable INSTALL_LMOD ${LUA})" \
		"--libdir=$($(tc-getPKG_CONFIG) --variable INSTALL_CMOD ${LUA})" \
		"LUA_INCLUDE=-I$($(tc-getPKG_CONFIG) --variable includedir ${LUA})"
	)
	base_src_configure "${myeconfargs[@]}"
}
