# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from Lua overlay; Bumped by mva; $

EAPI="5"

inherit eutils games

DESCRIPTION="A game prototype by Maurice (mari0 author)"
HOMEPAGE="http://stabyourself.net/other/"
SRC_URI="http://stabyourself.net/dl.php?file=${PN}/${PN}.love -> ${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT=""

DEPEND=">=games-engines/love-0.8.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
        local dir="${GAMES_DATADIR}/love/${PN}"
        insinto "${dir}"
        doins -r .
        games_make_wrapper "${PN}" "love /usr/share/games/love/${P}"
        make_desktop_entry "${PN}"
        prepgamesdirs
}

pkg_postinst() {
        elog "${PN} savegames and configurations are stored in:"
        elog "~/.local/share/love/${PN}/"
}
