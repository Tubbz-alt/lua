# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

VCS="git-r3"
LUA_COMPAT="luajit2"
inherit lua

DESCRIPTION="Session library for OpenResty implementing Secure Cookie Protocol"
HOMEPAGE="https://github.com/bungle/lua-resty-session"
SRC_URI=""

EGIT_REPO_URI="https://github.com/bungle/lua-${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	www-servers/nginx[nginx_modules_http_lua]
	dev-lua/lua-cjson
	dev-lua/resty-string
"
DEPEND="
	${RDEPEND}
"

READMES=( README.md )

each_lua_install() {
	dolua_jit lib/resty
}
