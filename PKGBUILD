# Maintainer:  <jujodeve@gmail.com>
pkgname=xprinterpos
pkgver=0.1
pkgrel=1
pkgdesc=" CUPS filter for XPrinter thermal printers"
arch=('x86_64')
url="https://github.com/jujodeve/xprinterpos.git"
license=('BSD')
depends=('cups')
makedepends=('minizip')
provides=('xprinterpos')

source=("git+https://github.com/jujodeve/xprinterpos.git")
md5sums=('SKIP')

package() {
    install -d -m 755 ${pkgdir}/usr/share/cups/model/xprinterpos/
    install -m 644 -D xprinterpos/ppd/*.ppd ${pkgdir}/usr/share/cups/model/xprinterpos/
    install -m 755 -D xprinterpos/filter/x64/rastertosnailep-pos ${pkgdir}/usr/lib/cups/filter/rastertosnailep-pos
}

# vim:set ts=2 sw=2 et:
