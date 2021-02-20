#_                   _ _ _  _ _____ _  _
#| | _______   ____ _| | | || |___  | || |
#| |/ / _ \ \ / / _` | | | || |_ / /| || |_
#|   <  __/\ V / (_| | | |__   _/ / |__   _|
#|_|\_\___| \_/ \__,_|_|_|  |_|/_/     |_|

#Maintainer: kevall474 <kevall474@tuta.io> <https://github.com/kevall474>
#Credits: Jan Alexander Steffens (heftig) <heftig@archlinux.org> ---> For the base PKGBUILD
#Credits: Andreas Radke <andyrtr@archlinux.org> ---> For the base PKGBUILD
#Credits: Linus Torvalds ---> For the linux kernel
#Credits: Joan Figueras <ffigue at gmail dot com> ---> For the base PKFBUILD and the GCC optimization script
#Credits: Piotr Gorski <lucjan.lucjanov@gmail.com> <https://github.com/sirlucjan/kernel-patches> ---> For the patches and the base pkgbuild
#Credits: Tk-Glitch <https://github.com/Tk-Glitch> ---> For some patches. base PKGBUILD and prepare script
#Credits: Con Kolivas <kernel@kolivas.org> <http://ck.kolivas.org/> ---> For MuQSS patches
#Credits: Hamad Al Marri <https://github.com/hamadmarri/cachy-sched> ---> For Cachy CPU Scheduler patch
#Credits: Hamad Al Marri <https://github.com/hamadmarri/cachy-sched> ---> For CacULE CPU Scheduler patch
#Credits: Alfred Chen <https://gitlab.com/alfredchen/projectc> ---> For the BMQ/PDS CPU Scheduler patch

#################################

#Set CPU Scheduler for stable and rc release
#Set '1' for MuQSS CPU Scheduler
#Set '2' for BMQ CPU Scheduler
#Set '3' for PDS CPU Scheduler
#Leave empty for no CPU Scheduler
#Default is empty. It will build with no cpu scheduler. To build with cpu shceduler just use : env _cpu_sched=(1,2 or 3) makepkg -s
if [ -z ${_cpu_sched+x} ]; then
  _cpu_sched=
fi

################################# Arch ################################

ARCH=x86

################################# CC/CXX/HOSTCC/HOSTCXX ################################

#Set compiler to build the kernel
#Set '1' to build with GCC
#Set '2' to build with GCC and LLVM
#Set '3' to build with CLANG
#Set '4' to build with CLANG and LLVM
#Default is empty. It will build with CLANG and LLVM. To build with different compiler just use : env _compiler=(1,2,3 or 4) makepkg -s
if [ -z ${_compiler+x} ]; then
  _compiler=
fi

if [[ "$_compiler" = "1" ]]; then
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
  buildwith="build with GCC"
elif [[ "$_compiler" = "2" ]]; then
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
  buildwith="build with GCC/LLVM"
elif [[ "$_compiler" = "3" ]]; then
  CC=clang
  CXX=clang++
  HOSTCC=clang
  HOSTCXX=clang++
  buildwith="build with CLANG"
elif [[ "$_compiler" = "4" ]]; then
  CC=clang
  CXX=clang++
  HOSTCC=clang
  HOSTCXX=clang++
  buildwith="build with CLANG/LLVM"
else
  _compiler=4
  CC=clang
  CXX=clang++
  HOSTCC=clang
  HOSTCXX=clang++
  buildwith="build with CLANG/LLVM"
fi

###################################################################################

# This section set the pkgbase based on the cpu scheduler. So user can build different package based on the cpu schduler for testing.
if [[ $_cpu_sched = "1" ]]; then
  pkgbase=linux-kernel-muqss
elif [[ $_cpu_sched = "2" ]]; then
  pkgbase=linux-kernel-bmq
elif [[ $_cpu_sched = "3" ]]; then
  pkgbase=linux-kernel-pds
else
  pkgbase=linux-kernel
fi
pkgname=("$pkgbase" "$pkgbase-headers")
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
  }"
done
pkgver=5.11
major=5.11
pkgrel=1
arch=(x86_64)
url="https://www.kernel.org/"
license=(GPL-2.0)
makedepends=("bison" "flex" "valgrind" "git" "cmake" "make" "extra-cmake-modules" "libelf" "elfutils"
             "python" "python-appdirs" "python-mako" "python-evdev" "python-sphinx_rtd_theme" "python-graphviz" "python-sphinx"
             "clang" "lib32-clang" "bc" "gcc" "gcc-libs" "lib32-gcc-libs" "glibc" "lib32-glibc" "pahole" "patch" "gtk3" "llvm" "lib32-llvm"
             "llvm-libs" "lib32-llvm-libs" "lld" "kmod" "libmikmod" "lib32-libmikmod" "xmlto" "xmltoman" "graphviz" "imagemagick" "imagemagick-doc"
             "rsync" "cpio" "inetutils")
patchsource=https://raw.githubusercontent.com/kevall474/kernel-patches/main/$major
source=("https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-$pkgver.tar.xz"
        "config-5.11"
        "$patchsource/misc/choose-gcc-optimization.sh"
        "$patchsource/zen-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-CLONE_NEWUSER.patch"
        "$patchsource/misc/0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch"
        "$patchsource/misc/0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch"
        "$patchsource/xanmod-patches/0001-sched-autogroup-Add-kernel-parameter-and-config-opti.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-VHBA-driver.patch"
        "$patchsource/futex-patches/0001-futex2-resync-from-gitlab.collabora.com.patch"
        "$patchsource/clearlinux-patches/0001-clearlinux-patches.patch"
        "$patchsource/ntfs3-patches/0001-ntfs3-patches.patch"
        "$patchsource/misc/0002-init-Kconfig-enable-O3-for-all-arches.patch"
        "$patchsource/block-patches/0001-block-patches.patch"
        "$patchsource/bfq-patches/5.11-bfq-reverts-ver1.patch"
        "$patchsource/bfq-patches/5.11-bfq-dev-lucjan-v14-r2K210208.patch"
        "$patchsource/aufs-patches/0001-aufs-20210111.patch"
        "$patchsource/bbr2-patches/0001-bbr2-5.11-introduce-BBRv2.patch"
        "$patchsource/btrfs-patches/0001-btrfs-patches.patch"
        "$patchsource/loopback-patches/0001-v4l2loopback-5.11-merge-v0.12.5.patch"
        "$patchsource/mm-patches/0001-mm-patches.patch"
        "$patchsource/spadfs-patches/0001-spadfs-5.11-merge-v1.0.12.patch"
        "$patchsource/zswap-patches/0001-zswap-patches.patch"
        "$patchsource/pf-patches/0001-pf-patches.patch"
        "$patchsource/miscellaneous-patches/0001-fixes-miscellaneous.patch"
        "$patchsource/arch-patches/0002-HID-quirks-Add-Apple-Magic-Trackpad-2-to-hid_have_sp.patch"
        "$patchsource/arch-patches/0002-Bluetooth-btusb-Some-Qualcomm-Bluetooth-adapters-sto.patch"
        "$patchsource/arch-patches/0003-Revert-drm-amd-display-reuse-current-context-instead.patch"
        "$patchsource/arch-patches/0004-drm-amdgpu-fix-shutdown-with-s0ix.patch"
        "$patchsource/android-patches/0001-Export-symbols-needed-by-Android-drivers.patch"
        "$patchsource/android-patches/0002-android-Enable-building-ashmem-and-binder-as-modules.patch"
        "$patchsource/ksm-patches/0001-ksm-patches.patch")
        #"$patchsource/uksm-patches/0001-UKSM-for-5.11.patch"
        #"$patchsource/iommu-patches/0006-add-acs-overrides_iommu.patch"
        #"$patchsource/aufs-patches/0001-aufs-20210215.patch"
        #"$patchsource/ZFS-patches/0011-ZFS-fix.patch
md5sums=("d2985a3f16ef1ea3405c04c406e29dcc"  #linux-5.11.tar.xz
         "efa5b2f5b6c05d0445198391bcb69a0e"  #config-5.11
         "b3f0a4804b6fe031f674988441c1af35"  #choose-gcc-optimization.sh
         "a724ee14cb7aee1cfa6e4d9770c94723"  #0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-CLONE_NEWUSER.patch
         "d15597054a4c5e405f980d07d5eac11a"  #0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch
         "f99b82d6f424d1a729a9b8c5a1be2b84"  #0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch
         "367fb55844e4a30aaff526ce4d9cd804"  #0001-sched-autogroup-Add-kernel-parameter-and-config-opti.patch
         "9a6ac945f08f93c6d778618100ddf753"  #0001-ZEN-Add-VHBA-driver.patch
         "307f39a7c060ac3073607964091234c0"  #0001-futex2-resync-from-gitlab.collabora.com.patch
         "57f4afa1be10eec300542767942ad938"  #0001-clearlinux-patches.patch
         "5c329c12318ee35bda48bb96a92c5aa9"  #0001-ntfs3-patches.patch
         "5ef95c9aa1a3010b57c9be03f8369abb"  #0002-init-Kconfig-enable-O3-for-all-arches.patch
         "374eac14e43ba8480fa74c8f51ebf4a5"  #0001-block-patches.patch
         "1003f5af700d5e9b3c3949143cae7579"  #5.11-bfq-reverts-ver1.patch
         "f626930d7bf3fa8cd3e99c1ee8fbdb74"  #5.11-bfq-dev-lucjan-v14-r2K210208.patch
         "f6b385b6f38178df8f4b037aabcf1404"  #0001-aufs-20210111.patch
         "686d82306fff905945ffb6f0eede14d4"  #0001-bbr2-5.11-introduce-BBRv2.patch
         "0eede73d784a27150c2a7720dea0f0fa"  #0001-btrfs-patches.patch
         "0ab93e8e3437a5093520c10cca741531"  #0001-v4l2loopback-5.11-merge-v0.12.5.patch
         "cc70bf905a1237a41b11338b2eba4a8b"  #0001-mm-patches.patch
         "ddcda13d2e86984517e841b4acebd2f5"  #0001-spadfs-5.11-merge-v1.0.12.patch
         "64e629e48f15cc0ebddfee366386f17a"  #0001-zswap-patches.patch
         "dcb506abf81826a5a005c9e66b4312f2"  #0001-pf-patches.patch
         "71f9d48d9acfdfc78ad68f5cb76b3333"  #0001-fixes-miscellaneous.patch
         "e7ef63d6e6fb1ed9d8c2b4d3f65de86c"  #0002-HID-quirks-Add-Apple-Magic-Trackpad-2-to-hid_have_sp.patch
         "5cbf26872b5e716d4c49acd309169633"  #0002-Bluetooth-btusb-Some-Qualcomm-Bluetooth-adapters-sto.patch
         "34d442266fadf10835a83f916e55cf58"  #0003-Revert-drm-amd-display-reuse-current-context-instead.patch
         "738f9c2c80f7c2e484291994259acbac"  #0004-drm-amdgpu-fix-shutdown-with-s0ix.patch
         "3b5866097de15af399841405bc844020"  #0001-Export-symbols-needed-by-Android-drivers.patch
         "0eda7e947dd25e6b77ea40d734deea8d"  #0002-android-Enable-building-ashmem-and-binder-as-modules.patch
         "9c37d7643710ffa49552cc43b96980ed") #0001-ksm-patches.patch
         #"3d4defdab76bf6c766b94ea41493db51"  #0001-UKSM-for-5.11.patch
         #"168a924c7c83ecdc872a9a1c6d1c8bdb"  #0006-add-acs-overrides_iommu.patch
         #"c11b864bb47868d5ab72360d960ff6a8"  #0001-aufs-20210215.patch
         #"SKIP" #0011-ZFS-fix.patch
if [[ $_cpu_sched = "1" ]]; then
 source+=("$patchsource/muqss-patches/patch-5.11-ck1")
 md5sums+=("SKIP")
elif [[ $_cpu_sched = "2" ]] || [[ $_cpu_sched = "3" ]]; then
  source+=("${patchsource}/prjc-patches/0009-prjc_v5.11-r0.patch")
  md5sums+=("f1f238aaae5f6a94defa70a0796ebd01")  #0009-prjc_v5.11-r0.patch
fi

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare(){

  cd linux-$pkgver

  # Apply any patch
  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch ]] || continue
    msg2 "Applying patch $src..."
    patch -Np1 < "../$src"
  done

  if [[ $_cpu_sched = "1" ]]; then
    msg2 "Applying patch patch-5.11-ck1"
    patch -Np1 < ../patch-5.11-ck1
 fi

  # Copy the config file first
  # Copy "${srcdir}"/config to linux-${pkgver}/.config
  msg2 "Copy "${srcdir}"/config to linux-$pkgver/.config"
  cp "${srcdir}"/config-$major .config

  source "${startdir}"/prepare

  configure

  # Let's user choose microarchitecture optimization in GCC
  sh ${srcdir}/choose-gcc-optimization.sh $_microarchitecture

  # Setting localversion
  msg2 "Setting localversion..."
  scripts/setlocalversion --save-scmversion
  echo "-${pkgbase}" > localversion

  # Config
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  elif [[ "$_compiler" = "3" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  elif [[ "$_compiler" = "4" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  fi

  make -s kernelrelease > version
  msg2 "Prepared $pkgbase version $(<version)"
}

build(){

  cd linux-$pkgver

  # make -j$(nproc) all
  msg2 "make -j$(nproc) all..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  elif [[ "$_compiler" = "3" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  elif [[ "$_compiler" = "4" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  fi
}

_package(){
  pkgdesc="Stable linux kernel and modules with a set of patches by TK-Glitch and Piotr Górski ${buildwith}"
  depends=("coreutils" "kmod" "initramfs" "mkinitcpio")
  optdepends=("linux-firmware: firmware images needed for some devices"
              "crda: to set the correct wireless channels of your country")
  provides=("VIRTUALBOX-GUEST-MODULES" "WIREGUARD-MODULE")

  cd linux-$pkgver

  local kernver="$(<version)"
  local modulesdir="${pkgdir}"/usr/lib/modules/${kernver}

  msg2 "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 arch/${ARCH}/boot/bzImage "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  msg2 "Installing modules..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  elif [[ "$_compiler" = "3" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  elif [[ "$_compiler" = "4" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  fi

  # remove build and source links
  msg2 "Remove build dir and source dir..."
  rm -rf "$modulesdir"/{source,build}
}

_package-headers(){
  pkgdesc="Headers and scripts for building modules for the $pkgbase package"
  depends=("${pkgbase}")

  cd linux-$pkgver

  local builddir="$pkgdir"/usr/lib/modules/"$(<version)"/build

  msg2 "Installing build files..."
  install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map localversion version vmlinux
  install -Dt "$builddir/kernel" -m644 kernel/Makefile
  install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
  cp -t "$builddir" -a scripts

  # add objtool for external module building and enabled VALIDATION_STACK option
  install -Dt "$builddir/tools/objtool" tools/objtool/objtool

  # add xfs and shmem for aufs building
  mkdir -p "$builddir"/{fs/xfs,mm}

  msg2 "Installing headers..."
  cp -t "$builddir" -a include
  cp -t "$builddir/arch/x86" -a arch/x86/include
  install -Dt "$builddir/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "$builddir/drivers/md" -m644 drivers/md/*.h
  install -Dt "$builddir/net/mac80211" -m644 net/mac80211/*.h

  # http://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # http://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  msg2 "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "$builddir/{}" \;

  msg2 "Removing unneeded architectures..."
  local arch
  for arch in "$builddir"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    msg2 "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  msg2 "Removing documentation..."
  rm -r "$builddir/Documentation"

  msg2 "Removing broken symlinks..."
  find -L "$builddir" -type l -printf 'Removing %P\n' -delete

  msg2 "Removing loose objects..."
  find "$builddir" -type f -name '*.o' -printf 'Removing %P\n' -delete

  msg2 "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -bi "$file")" in
      application/x-sharedlib\;*)      # Libraries (.so)
        strip -v $STRIP_SHARED "$file" ;;
      application/x-archive\;*)        # Libraries (.a)
        strip -v $STRIP_STATIC "$file" ;;
      application/x-executable\;*)     # Binaries
        strip -v $STRIP_BINARIES "$file" ;;
      application/x-pie-executable\;*) # Relocatable binaries
        strip -v $STRIP_SHARED "$file" ;;
    esac
  done < <(find "$builddir" -type f -perm -u+x ! -name vmlinux -print0)

  msg2 "Stripping vmlinux..."
  strip -v $STRIP_STATIC "$builddir/vmlinux"

  msg2 "Adding symlink..."
  mkdir -p "$pkgdir/usr/src"
  ln -sr "$builddir" "$pkgdir/usr/src/$pkgbase"
}
