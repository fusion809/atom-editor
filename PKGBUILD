# Maintainer: Brenton Horne <brentonhorne77 at gmail dot com>

_pkgname=atom

# Module Versions
_about_arch_ver=1.6.2
_language_gfm2_ver=0.92.2
_language_liquid_ver=0.5.1
_language_unix_shell_ver=0.37.7

pkgname=${_pkgname}-editor
_pkgver=1.9.9
pkgver=${_pkgver}.a${_about_arch_ver}.g${_language_gfm2_ver}.l${_language_liquid_ver}.u${_language_unix_shell_ver}
pkgrel=1
pkgdesc='Hackable text editor for the 21st Century, built using web technologies.'
arch=('x86_64' 'i686')
url='https://github.com/atom/atom'
license=('MIT')
depends=('alsa-lib' 'desktop-file-utils' 'gconf' 'gtk2' 'libgnome-keyring' 'libnotify' 'libxtst' 'nodejs>=4' 'nss' 'python2')
optdepends=('gvfs: file deletion support')
makedepends=('git' 'npm>=3.10.5')
conflicts=('atom-editor-bin')
install=atom.install
source=("${_pkgname}-${_pkgver}.tar.gz::https://github.com/atom/atom/archive/v${_pkgver}.tar.gz"
"about-arch-${_about_arch_ver}.tar.gz::https://github.com/fusion809/about/archive/v${_about_arch_ver}.tar.gz"
"atom.desktop")
sha512sums=('813943e67b1bf7f2905b2e1c6f3beeee9f22f6faf73015e3b2cc519262d53047322c2d6fbd34e924933688c8bc80be9bbc99f1ff666a26c24eab81497bce39de'
            'd8ca0f819f5561a0c0348d1bec57fdd0ce626db64085b60124fd04f95b467a56c96cf77aa93d22e44f562b75f12de47a9820988533fccbb3a12f69d83ef5b45a'
            'beb160ec2fe8f917ba159ca42fca305ea2bb4c2ae5c6cfc3dd9170e17ece527ccb993cdf907467c7392221bd1f50fc2337241dadfe6895d67f55e69a15715556')

prepare() {
  cd "$srcdir/${_pkgname}-${_pkgver}"

  sed -i -e "/exception-reporting/d" \
         -e "/metrics/d" \
         -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"${_language_gfm2_ver}\",\n    \"language-liquid\": \"${_language_liquid_ver}\",/g" \
         -e "s/\"language-shellscript\": \".*\",/\"language-unix-shell\": \"${_language_unix_shell_ver}\",/g" \
         -e "s/\"about\": \".*\"/\"about-arch\": \"${_about_arch_ver}\"/g" \
         package.json

  chmod 755 -R package.json

  sed -i -e 's@node script/bootstrap@node script/bootstrap --no-quiet@g' \
  ./script/build || die "Fail fixing verbosity of script/build"

  sed -i -e "s/<%=Desc=%>/$pkgdesc/g" ${srcdir}/${_pkgname}.desktop

  if ! [[ -d node_modules/about-arch ]]; then
  	mkdir node_modules
  else
    rm -rf node_modules/about-arch
  fi

  mv $srcdir/about-${_about_arch_ver} node_modules/about-arch
}

build() {
  cd "$srcdir/${_pkgname}-${_pkgver}"
  export PYTHON=/usr/bin/python2
  until ./script/build --build-dir "$srcdir/atom-build"; do :; done
}

package() {
  cd "$srcdir/${_pkgname}-${_pkgver}"

  script/grunt install --build-dir "$srcdir/atom-build" --install-dir "$pkgdir/usr"

  install -Dm644 $srcdir/${_pkgname}.desktop "$pkgdir/usr/share/applications/${_pkgname}.desktop"
  install -Dm644 resources/app-icons/stable/png/1024.png "$pkgdir/usr/share/pixmaps/atom.png"
  install -Dm644 LICENSE.md "$pkgdir/usr/share/licenses/$pkgname/LICENSE.md"
}
