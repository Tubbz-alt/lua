# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from Lua overlay; Bumped by mva; $

EAPI="4"

inherit pax-utils

MY_P="LuaJIT-${PV}"

DESCRIPTION="A Just-In-Time Compiler for the Lua programming language."
HOMEPAGE="http://luajit.org/"
SRC_URI="http://luajit.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="readline"

CDEPEND="dev-lang/lua"
DEPEND="${CDEPEND}
	readline? ( sys-libs/readline )
	app-admin/eselect-luajit"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare(){
	# fixing prefix
	sed -i -e "s#/usr/local#${D}/usr#" Makefile \
		|| die "failed to fix prefix in Makefile"
	sed -i -e 's#/usr/local/#/usr/#' src/luaconf.h \
		|| die "failed to fix prefix in luaconf.h"

	# forcing the use of our CFLAGS
	sed -i -e "s/\$(MYCFLAGS)/\$(MYCFLAGS) ${CFLAGS}/" src/Makefile \
		|| die "failed to force the use of the CFLAGS from the user"
}

src_compile(){
	if use readline; then
		emake linux_rl || die "emake failed."
	else
		emake linux || die "emake failed."
	fi
}

src_install(){
	einstall

	# removing empty dir that was supposed to have the man pages.
	# dev-lang/luajit:1 doesn't install man pages.
	rm -rf "${D}usr/man"

	mv "${D}usr/bin/luajit" "${D}usr/bin/luajit-${PV}" || die "mv failed!"
	pax-mark m "${D}usr/bin/luajit-${PV}"
	dosym "luajit-${PV}" "/usr/bin/luajit-${SLOT}"
}

pkg_postinst() {
	ewarn "Now you should select LuaJIT version to use as system default LuaJIT interpreter."
	ewarn "Use 'eselect luajit list' to look for installed versions and"
	ewarn "Use 'eselect luajit set <NUMBER_or_NAME>' to set version you chose."
}
