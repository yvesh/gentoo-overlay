# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MY_PV="${PV/_beta/-beta.}"
MY_P="${MY_PN}_${MY_PV}"

inherit desktop gnome2-utils multilib-build pax-utils unpacker xdg-utils

DESCRIPTION="Linux time tracking and task management"
HOMEPAGE="https://empoche.com/"
SRC_URI="https://empoche-desktop.s3.eu-central-1.amazonaws.com/${MY_P}_amd64.deb"

LICENSE="Apache-2.0 empoche"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libpcre:3
	dev-libs/libtasn1:0
	dev-libs/nettle:0
	dev-libs/nspr:0
	dev-libs/nss:0
	gnome-base/gconf:2
	media-libs/alsa-lib:0
	media-libs/libpng:0
	net-libs/gnutls:0
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver:0"
RDEPEND="${DEPEND}"

QA_PREBUILT="
	opt/Empoche/empoche
	opt/Empoche/libnode.so
	opt/Empoche/libffmpeg.so
"

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/.
	fperms +x /opt/Empoche/empoche
	dosym ../../opt/Empoche/empoche usr/bin/empoche

	domenu usr/share/applications/empoche.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/.
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}