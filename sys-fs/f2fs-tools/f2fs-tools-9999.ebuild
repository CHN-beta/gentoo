# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE="https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/about/"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/${PN}.git"
EGIT_BRANCH="dev"

LICENSE="GPL-2"
SLOT="0/9"
IUSE="selinux"

RDEPEND="
	selinux? ( sys-libs/libselinux )
	elibc_musl? ( sys-libs/queue-standalone )"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# This is required to install to /sbin, bug #481110
	econf \
		--bindir="${EPREFIX}"/sbin \
		--disable-static \
		$(use_with selinux)
}

src_install() {
	default
	find "${D}" -name "*.la" -delete || die
}
