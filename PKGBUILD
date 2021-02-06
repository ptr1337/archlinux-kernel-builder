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
#Set '1' for Cachy CPU Scheduler
#Set '2' for CacULE CPU Scheduler
#Set '3' for MuQSS CPU Scheduler
#Set '4' for BMQ CPU Scheduler
#Set '5' for PDS CPU Scheduler
#Set '6' for UPDS CPU Scheduler
#Set '7' for CacULE-rdb CPU Scheduler
#Set '8' for Cachy-idle CPU Scheduler
#Leave empty for no CPU Scheduler
#Default is empty. It will build with no cpu scheduler. To build with cpu shceduler just use : env _cpu_sched=(1,2,3,4, or 6) makepkg -s
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
  pkgbase=linux-kernel-cachy
elif [[ $_cpu_sched = "2" ]]; then
  pkgbase=linux-kernel-cacule
elif [[ $_cpu_sched = "3" ]]; then
  pkgbase=linux-kernel-muqss
elif [[ $_cpu_sched = "4" ]]; then
  pkgbase=linux-kernel-bmq
elif [[ $_cpu_sched = "5" ]]; then
  pkgbase=linux-kernel-pds
elif [[ $_cpu_sched = "6" ]]; then
  pkgbase=linux-kernel-upds
elif [[ $_cpu_sched = "7" ]]; then
  pkgbase=linux-kernel-cacule-rdb
elif [[ $_cpu_sched = "8" ]]; then
  pkgbase=linux-kernel-cachy-idle
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
pkgver=5.10.13
major=5.10
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
        "config-5.10"
        "$patchsource/misc/choose-gcc-optimization.sh"
        "$patchsource/zen-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-CLONE_NEWUSER.patch"
        "$patchsource/misc/0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch"
        "$patchsource/misc/0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch"
        "$patchsource/xanmod-patches/0001-sched-autogroup-Add-kernel-parameter-and-config-opti.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-VHBA-driver.patch"
        "$patchsource/futex-patches/0001-futex-patches.patch"
        "$patchsource/clearlinux-patches/0001-clearlinux-patches.patch"
        #"$patchsource/ZFS-patches/0011-ZFS-fix.patch"
        "$patchsource/fs-patches/0001-fs-patches.patch"
        "$patchsource/ntfs3-patches/0001-ntfs3-patches.patch"
        "$patchsource/misc/0002-init-Kconfig-enable-O3-for-all-arches.patch"
        "$patchsource/block-patches/0001-block-patches.patch"
        "$patchsource/bfq-patches/5.10-bfq-reverts-ver1.patch"
        "$patchsource/bfq-patches/5.10-bfq-dev-lucjan-v14-r2K210125.patch")
	#"$patchsource/btrfs-patches/0001-btrfs-patches.patch")
md5sums=("2427bad3186737a954c2b713d53ec26d"  #linux-5.10.13.tar.xz
         "37e6b22c1ba142850a1f8432ea15bd2d"  #config-5.10
         "b3f0a4804b6fe031f674988441c1af35"  #choose-gcc-optimization.sh
         "a724ee14cb7aee1cfa6e4d9770c94723"  #0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-CLONE_NEWUSER.patch
         "d15597054a4c5e405f980d07d5eac11a"  #0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch
         "f99b82d6f424d1a729a9b8c5a1be2b84"  #0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch
         "34764d6a1af6ab2e06ef6efa95aaa467"  #0001-sched-autogroup-Add-kernel-parameter-and-config-opti.patch
         "a0188e575abe3f27bde9ec09462b067e"  #0001-ZEN-Add-VHBA-driver.patch
         "c97b042c437883db1e768ff474e8b35c"  #0001-futex-patches.patch
         "eb812a74ec92add2108b48f5a9f048fc"  #0001-clearlinux-patches.patch
         #"c19fd76423bfc4af45d99585cedb2623"  #0011-ZFS-fix.patch
         "656de58729054bb71c9dc5dee737e589"  #0001-fs-patches.patch
         "8e7e07e22a52c3deaf28ed7595d634c7"  #0001-ntfs3-patches.patch
         "5ef95c9aa1a3010b57c9be03f8369abb"  #0002-init-Kconfig-enable-O3-for-all-arches.patch
         "08c1f6c132af32dea0da37144291f117"  #0001-block-patches.patch
         "0acd0ffeafb417974cc4c7de0f1a6f58"  #5.10-bfq-reverts-ver1.patch
         "741b6049dc5d5dfcaa3f812126f56a8a") #5.10-bfq-dev-lucjan-v14-r2K210125.patch
	       #"SKIP") #0001-btrfs-patches.patch
if [[ $_cpu_sched = "1" ]]; then
  source+=("$patchsource/cachy-patches/cachy-5.9-r9.patch")
  md5sums+=("53703024438eca5e4700edf486e2c50e")  #cachy-5.9-r9.patch
elif [[ $_cpu_sched = "2" ]]; then
  source+=("$patchsource/cacule-patches/cacule5.10-r2.patch")
  md5sums+=("e5c7ba93acbcabd6a4641cab717bf4b9")  #cacule5.10-r2.patch
elif [[ $_cpu_sched = "3" ]]; then
  source+=("$patchsource/muqss-patches/0001-MultiQueue-Skiplist-Scheduler-v0.205.patch"
           "$patchsource/muqss-patches/0003-Expose-vmsplit-for-our-poor-32-bit-users.patch"
           "$patchsource/muqss-patches/0004-Create-highres-timeout-variants-of-schedule_timeout-.patch"
           "$patchsource/muqss-patches/0005-Special-case-calls-of-schedule_timeout-1-to-use-the-.patch"
           "$patchsource/muqss-patches/0006-Convert-msleep-to-use-hrtimers-when-active.patch"
           "$patchsource/muqss-patches/0007-Replace-all-schedule-timeout-1-with-schedule_min_hrt.patch"
           "$patchsource/muqss-patches/0008-Replace-all-calls-to-schedule_timeout_interruptible-.patch"
           "$patchsource/muqss-patches/0009-Replace-all-calls-to-schedule_timeout_uninterruptibl.patch"
           "$patchsource/muqss-patches/0010-Don-t-use-hrtimer-overlay-when-pm_freezing-since-som.patch"
           "$patchsource/muqss-patches/0012-Make-threaded-IRQs-optionally-the-default-which-can-.patch"
           "$patchsource/muqss-patches/0014-Swap-sucks.patch"
           "$patchsource/muqss-patches/0015-Make-nohz_full-not-be-picked-up-as-a-default-config-.patch")
  md5sums+=("50c0959e72d14fdf3335e77d51c270c1"  #0001-MultiQueue-Skiplist-Scheduler-v0.205.patch
            "65c80aa95e9afcce96b36dd5be6cdac2"  #0003-Expose-vmsplit-for-our-poor-32-bit-users.patch
            "4a4ba97ebbce56323746cd693687647b"  #0004-Create-highres-timeout-variants-of-schedule_timeout-.patch
            "6a79f8fe23c064971d0ccd319fde5c7c"  #0005-Special-case-calls-of-schedule_timeout-1-to-use-the-.patch
            "390d298f70829def34ef0dcb9980dc9f"  #0006-Convert-msleep-to-use-hrtimers-when-active.patch
            "bafd17a7b185c591430d80b5ad31a73d"  #0007-Replace-all-schedule-timeout-1-with-schedule_min_hrt.patch
            "8d9dbc22ae00e3350dc634079624e870"  #0008-Replace-all-calls-to-schedule_timeout_interruptible-.patch
            "8deced6a0bd70196990aa1fa486150ca"  #0009-Replace-all-calls-to-schedule_timeout_uninterruptibl.patch
            "ec2b8d887d3c551df7a54684a2a14b1d"  #0010-Don-t-use-hrtimer-overlay-when-pm_freezing-since-som.patch
            "cd4eb5dc10e65316ab97240ff625f2f4"  #0012-Make-threaded-IRQs-optionally-the-default-which-can-.patch
            "a255d2b4322c19b1398268a8d5358354"  #0014-Swap-sucks.patch
            "bdd3600c90f924f2066384a16b6550af") #0015-Make-nohz_full-not-be-picked-up-as-a-default-config-.patch
elif [[ $_cpu_sched = "4" ]] || [[ $_cpu_sched = "5" ]]; then
  source+=("${patchsource}/prjc-patches/0009-prjc_v5.10-r2.patch")
  md5sums+=("e9e4bf29f301797bdca56374b51a4bf3")  #0009-prjc_v5.10-r2.patch
elif [[ $_cpu_sched = "6" ]]; then
  source+=("${patchsource}/upds-patches/0005-v5.10_undead-pds099o.patch")
  md5sums+=("07bc120fe6a43feae936e612c288fa13")  #0005-v5.10_undead-pds099o.patch
elif [[ $_cpu_sched = "7" ]]; then
  source+=("${patchsource}/cacule/cacule5.10-rdb.patch")
  md5sums+=("SKIP")  #cacule5.10-rdb.patch
elif [[ $_cpu_sched = "8" ]]; then
  source+=("${patchsource}/cachy-patches/cachy-5.9-r9.patch"
  	   "${patchsource}/cachy-patches/02-idle_balance.patch")
  md5sums+=("53703024438eca5e4700edf486e2c50e"  #cachy-5.9-r9.patch
  	    "SKIP") #02-idle_balance.patch
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
