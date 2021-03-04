PKG_NAME="AlekFull-Solo-Horizontal"
PKG_VERSION="b567b1ed202c27645d343b6c68a92dd32cb0c604"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="git@github.com:SummerSunGenius/AlekFull-Solo-Horizontal.git"
PKG_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emuelec"
PKG_SHORTDESC="The EmulationStation theme Carbon Fabrice Caruso's fork with changes for EmuELEC by drixplm"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"

make_target() {
  : not
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/emulationstation/themes/AlekFull-Solo-Horizontal
    cp -r * $INSTALL/usr/config/emulationstation/themes/AlekFull-Solo-Horizontal
}
