let

  # Shell derivation condensed from https://git.petabyte.dev/petabyteboy/corenix

  # nix-shell -E 'import (builtins.fetchurl "$url")'

  name = "nix-shell.coreboot";
  architecture = "i386";
  url = "https://review.coreboot.org/coreboot";
  project = "${builtins.getEnv "HOME"}/Shares/Projects/coreboot";

  pkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/20.09/nixos-20.09.3824.dec334fa196/nixexprs.tar.xz";
    sha256 = "1i38d1z672gzn73k6gsas2zjbbradg06w7dw3zs9f64l0hr3qd94"; }) {};

  dependencies = { fetchurl }: [
    rec { name = "Python-3.8.5.tar.xz";                 archive = fetchurl { sha256 = "1c43dbv9lvlp3ynqmgdi4rh8q94swanhqarqrdx62zmigpakw073"; url = "https://www.python.org/ftp/python/3.8.5/${name}";                               }; }
    rec { name = "acpica-unix2-20200717.tar.gz";        archive = fetchurl { sha256 = "0jyy71szjr40c8v40qqw6yh3gfk8d6sl3nay69zrn5d88i3r0jca"; url = "https://acpica.org/sites/acpica/files/${name}";                                 }; }
    rec { name = "binutils-2.35.tar.xz";                archive = fetchurl { sha256 = "119g6340ksv1jkg6bwaxdp2whhlly22l9m30nj6y284ynjgna48v"; url = "https://ftpmirror.gnu.org/binutils/${name}";                                    }; }
    rec { name = "clang-10.0.1.src.tar.xz";             archive = fetchurl { sha256 = "091bvcny2lh32zy8f3m9viayyhb2zannrndni7325rl85cwgr6pr"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/${name}"; }; }
    rec { name = "clang-tools-extra-10.0.1.src.tar.xz"; archive = fetchurl { sha256 = "06n1yp638rh24xdxv9v2df0qajxbjz4w59b7dd4ky36drwmpi4yh"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/${name}"; }; }
    rec { name = "cmake-3.18.1.tar.gz";                 archive = fetchurl { sha256 = "0215srmc9l7ygwdpfms8yx0wbd96qgz2d58ykmdiarvysf5k7qy0"; url = "https://cmake.org/files/v3.18/${name}";                                         }; }
    rec { name = "compiler-rt-10.0.1.src.tar.xz";       archive = fetchurl { sha256 = "1yjqjri753w0fzmxcyz687nvd97sbc9rsqrxzpq720na47hwh3fr"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/${name}"; }; }
    rec { name = "expat-2.2.9.tar.bz2";                 archive = fetchurl { sha256 = "0dx2m58gkj7cadk51lmp54ma7cqjhff4kjmwv8ks80j3vj2301pi"; url = "https://github.com/libexpat/libexpat/releases/download/R_2_2_9/${name}";        }; }
    rec { name = "gcc-8.3.0.tar.xz";                    archive = fetchurl { sha256 = "0b3xv411xhlnjmin2979nxcbnidgvzqdf4nbhix99x60dkzavfk4"; url = "https://ftpmirror.gnu.org/gcc/gcc-8.3.0/${name}";                               }; }
    rec { name = "gdb-9.2.tar.xz";                      archive = fetchurl { sha256 = "0mf5fn8v937qwnal4ykn3ji1y2sxk0fa1yfqi679hxmpg6pdf31n"; url = "https://ftpmirror.gnu.org/gdb/${name}";                                         }; }
    rec { name = "gmp-6.2.0.tar.xz";                    archive = fetchurl { sha256 = "09hmg8k63mbfrx1x3yy6y1yzbbq85kw5avbibhcgrg9z3ganr3i5"; url = "https://ftpmirror.gnu.org/gmp/${name}";                                         }; }
    rec { name = "llvm-10.0.1.src.tar.xz";              archive = fetchurl { sha256 = "1wydhbp9kyjp5y0rc627imxgkgqiv3dfirbqil9dgpnbaw5y7n65"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/${name}"; }; }
    rec { name = "mpc-1.2.0.tar.gz";                    archive = fetchurl { sha256 = "19pxx3gwhwl588v496g3aylhcw91z1dk1d5x3a8ik71sancjs3z9"; url = "https://ftpmirror.gnu.org/mpc/${name}";                                         }; }
    rec { name = "mpfr-4.1.0.tar.xz";                   archive = fetchurl { sha256 = "0zwaanakrqjf84lfr5hfsdr7hncwv9wj0mchlr7cmxigfgqs760c"; url = "https://ftpmirror.gnu.org/mpfr/${name}";                                        }; }
    rec { name = "nasm-2.15.03.tar.bz2";                archive = fetchurl { sha256 = "0y6p3d5lhmwzvgi85f00sz6c485ir33zd1nskzxby4pikcyk9rq4"; url = "https://www.nasm.us/pub/nasm/releasebuilds/2.15.03/${name}";                    }; }
  ];

  toolchain = pkgs.stdenv.mkDerivation rec {
    pname = "crossgcc-${architecture}";
    version = "4.13";
    src = pkgs.fetchgit {
      inherit url;
      rev = version;
      sha256 = "0xwzwplyf2zc267ddprh7963p582q3jrdvxc7r4cwzj0lhgrv6rv";
      fetchSubmodules = true;
    };

    nativeBuildInputs = builtins.attrValues { inherit (pkgs) curl m4 flex bison zlib gnat; };

    buildPhase = ''
      mkdir -p util/crossgcc/tarballs
      ${pkgs.lib.concatMapStringsSep "\n"
      (file: "ln -s ${file.archive} util/crossgcc/tarballs/${file.name}")
      (pkgs.callPackage dependencies { })}
      NIX_HARDENING_ENABLE="$\{NIX_HARDENING_ENABLE/ format/\}" make crossgcc-i386 CPUS=$(nproc)
    '';

    installPhase = ''
      runHook preInstall
      cp -r util/crossgcc $out
      runHook postInstall
    '';
  };

in pkgs.mkShell {

  inherit name;

  buildInputs = builtins.attrValues { inherit (pkgs) git coreboot-utils flashrom me_cleaner ncurses qemu m4 flex bison zlib gnat; };

  shellHook = ''
    export PS1='\h (${name}) \W \$ '
    mkdir -p '${project}'
    git clone '${url}' '${project}' || true
    cd '${project}' || exit 1
    rm -rf util/crossgcc
    ln -sf ${toolchain} util/crossgcc
    sed -i 's|$(OBJCOPY) --strip-$(STRIP) $< $@|$(OBJCOPY) --strip-debug $< $@|g' payloads/libpayload/Makefile.payload

    printf '
    flashrom --programmer internal                                      # read BIOS chipset internally if possible
    flashrom --programmer internal   --read backup.rom  --chip $chipset # read BIOS internally if possible with selected chipset
    flashrom --programmer internal   --read backup1.rom --chip $chipset
    flashrom --programmer internal   --read backup2.rom --chip $chipset
    flashrom --programmer internal   --read backup3.rom --chip $chipset
    flashrom --programmer ch341a_spi --read backup.rom  --chip $chipset # use an external programmer if internal does not work
    sha256sum *.rom                                                     # check BIOS hashes for exactness
    me_cleaner.py --soft-disable backup.rom                             # clean management engine and overwrite bios inplace
    ifdtool --extract backup.rom                                        # split regions of cleaned bios

    # Rename and move descriptor.bin, gbe.bin, me.bin into 3rdparty/blobs/mainboard/$vendor/$model where
    # $vendor and $model are variable (for example lenovo/t420). Create folders if they do not exist.
    # To test in qemu select model/vendor Emulation/QEMU x86 i440fx/piix4 in nconfig.
    # In real world situations, one might only read and write internally to the bios region.

    flashrom --programmer internal --read  bios.rom --chip $chipset --ifd --image bios
    flashrom --programmer internal --write bios.rom --chip $chipset --ifd --image bios

    make distclean                                                      # clear old configuration
    make clean                                                          # clear old compilation and keep configuration
    make nconfig                                                        # setup configurtion
    cat .config                                                         # check configuration
    make                                                                # build coreboot
    qemu-system-x86_64 -bios build/coreboot.rom -serial stdio           # test image in qemu

    '
  '';
}
