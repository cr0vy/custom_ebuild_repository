# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode"
HOMEPAGE="https://vscodium.com"
SRC_URI="https://github.com/VSCodium/vscodium/releases/download/1.46.1/VSCodium-linux-x64-1.46.1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="libsecret"

DEPEND="
        >=media-libs/libpng-1.2.46:0
        >=x11-libs/gtk+-3.0:3
        x11-libs/cairo
        x11-libs/libXtst"
RDEPEND="
        ${DEPEND}
        >=net-print/cups-2.0.0
        x11-libs/libnotify
        x11-libs/libXScrnSaver
        dev-libs/nss
        libsecret? ( app-crypt/libsecret[crypt] )"
BDEPEND=""

QA_PRESTRIPPED="opt/VSCodium/vscodium"

S="${WORKDIR}"

src_install(){
    pax-mark m code
    insinto "/opt/VSCodium"
    doins -r *
    dosym "../../opt/VSCodium/bin/codium" "/usr/bin/vscodium"
    dosym "../../opt/VSCodium/bin/codium" "/usr/bin/codium"
    make_desktop_entry "VSCodium" "Visual Studio Code" "VSCodium" "Development;IDE"
    doicon "${FILESDIR}/code.png"
    fperms +x "/opt/VSCodium/codium"
    fperms +x "/opt/VSCodium/bin/codium"
    fperms +x "/opt/VSCodium/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
    fperms +x "/opt/VSCodium/resources/app/extensions/git/dist/askpass.sh"
    insinto "/usr/share/licenses/VSCodium"
    for i in resources/app/LICEN*; do
        newins "${i}" "$(basename ${i})"
    done
}
