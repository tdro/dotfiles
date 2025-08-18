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
    rec { name = "llvm-${version}.src.tar.xz";              version = "11.0.0";   archive = fetchurl { sha256 = "0s94lwil98w7zb7cjrbnxli0z7gklb312pkw74xs1d6zk346hgwi"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-${version}/${name}"; }; }
    rec { name = "clang-${version}.src.tar.xz";             version = "11.0.0";   archive = fetchurl { sha256 = "091bvcny2lh32zy8f3m9viayyhb2zannrndni7325rl85cwgr6pr"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-${version}/${name}"; }; }
    rec { name = "clang-tools-extra-${version}.src.tar.xz"; version = "11.0.0";   archive = fetchurl { sha256 = "02bcwwn54661madhq4nxc069s7p7pj5gpqi8ww50w3anbpviilzy"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-${version}/${name}"; }; }
    rec { name = "compiler-rt-${version}.src.tar.xz";       version = "11.0.0";   archive = fetchurl { sha256 = "1yjqjri753w0fzmxcyz687nvd97sbc9rsqrxzpq720na47hwh3fr"; url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-${version}/${name}"; }; }
    rec { name = "Python-${version}.tar.xz";                version = "3.8.5";    archive = fetchurl { sha256 = "1c43dbv9lvlp3ynqmgdi4rh8q94swanhqarqrdx62zmigpakw073"; url = "https://www.python.org/ftp/python/${version}/${name}";                              }; }
    rec { name = "acpica-unix2-${version}.tar.gz";          version = "20200925"; archive = fetchurl { sha256 = "18n6129fkgj85piid7v4zxxksv3h0amqp4p977vcl9xg3bq0zd2w"; url = "https://acpica.org/sites/acpica/files/${name}";                                     }; }
    rec { name = "binutils-${version}.tar.xz";              version = "2.35.1";   archive = fetchurl { sha256 = "01w6xvfy7sjpw8j08k111bnkl27j760bdsi0wjvq44ghkgdr3v9w"; url = "https://ftpmirror.gnu.org/binutils/${name}";                                        }; }
    rec { name = "cmake-${version}.1.tar.gz";               version = "3.18";     archive = fetchurl { sha256 = "0215srmc9l7ygwdpfms8yx0wbd96qgz2d58ykmdiarvysf5k7qy0"; url = "https://cmake.org/files/v${version}/${name}";                                       }; }
    rec { name = "expat-${version}.tar.bz2";                version = "2.2.9";    archive = fetchurl { sha256 = "0dx2m58gkj7cadk51lmp54ma7cqjhff4kjmwv8ks80j3vj2301pi"; url = "https://distfiles.macports.org/expat/${name}";                                      }; }
    rec { name = "gcc-${version}.tar.xz";                   version = "8.3.0";    archive = fetchurl { sha256 = "0b3xv411xhlnjmin2979nxcbnidgvzqdf4nbhix99x60dkzavfk4"; url = "https://ftpmirror.gnu.org/gcc/gcc-${version}/${name}";                              }; }
    rec { name = "gdb-${version}.tar.xz";                   version = "9.2";      archive = fetchurl { sha256 = "0mf5fn8v937qwnal4ykn3ji1y2sxk0fa1yfqi679hxmpg6pdf31n"; url = "https://ftpmirror.gnu.org/gdb/${name}";                                             }; }
    rec { name = "gmp-${version}.tar.xz";                   version = "6.2.0";    archive = fetchurl { sha256 = "09hmg8k63mbfrx1x3yy6y1yzbbq85kw5avbibhcgrg9z3ganr3i5"; url = "https://ftpmirror.gnu.org/gmp/${name}";                                             }; }
    rec { name = "mpc-${version}.tar.gz";                   version = "1.2.0";    archive = fetchurl { sha256 = "19pxx3gwhwl588v496g3aylhcw91z1dk1d5x3a8ik71sancjs3z9"; url = "https://ftpmirror.gnu.org/mpc/${name}";                                             }; }
    rec { name = "mpfr-${version}.tar.xz";                  version = "4.1.0";    archive = fetchurl { sha256 = "0zwaanakrqjf84lfr5hfsdr7hncwv9wj0mchlr7cmxigfgqs760c"; url = "https://ftpmirror.gnu.org/mpfr/${name}";                                            }; }
    rec { name = "nasm-${version}.tar.bz2";                 version = "2.15.05";  archive = fetchurl { sha256 = "1l1gxs5ncdbgz91lsl4y7w5aapask3w02q9inayb2m5bwlwq6jrw"; url = "https://www.nasm.us/pub/nasm/releasebuilds/${version}/${name}";                     }; }
  ];

  toolchain = pkgs.stdenv.mkDerivation rec {
    pname = "crossgcc-${architecture}";
    version = "4.14";
    src = pkgs.fetchgit {
      inherit url;
      rev = version;
      fetchSubmodules = true;
      sha256 = "00xr74yc0kj9rrqa1a8b7bih865qlp9i4zs67ysavkfrjrwwssxm";
    };

    hardeningDisable = [ "format" ];
    nativeBuildInputs = builtins.attrValues { inherit (pkgs) curl m4 flex bison zlib gnat; };

    buildPhase = ''
      mkdir --parents util/crossgcc/tarballs
      ${pkgs.lib.concatMapStringsSep "\n" (file: "ln -s ${file.archive} util/crossgcc/tarballs/${file.name}") (pkgs.callPackage dependencies { })}
      sed "s/SOURCE_DATE_EPOCH := .*/SOURCE_DATE_EPOCH := $SOURCE_DATE_EPOCH/" --in-place Makefile
      make crossgcc-${architecture} CPUS=$(nproc)
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
    git fetch --all
    git reset --hard origin/master
    git checkout ${toolchain.version}
    rm -rf util/crossgcc
    ln -sf ${toolchain} util/crossgcc
    sed -i 's|$(OBJCOPY) --strip-$(STRIP) $< $@|$(OBJCOPY) --strip-debug $< $@|g' payloads/libpayload/Makefile.payload

    printf '
    flashrom --programmer ch341a_spi                                          # list detected chips from external programmer
    flashrom --programmer ch341a_spi --read backup1.rom  --chip $chipset      # read BIOS from external programmer
    flashrom --programmer ch341a_spi --read backup2.rom  --chip $chipset      # read BIOS from external programmer
    flashrom --programmer ch341a_spi --read backup3.rom  --chip $chipset      # read BIOS from external programmer
    flashrom --programmer internal                                            # list detected chips internally
    flashrom --programmer internal   --read backup1.rom --chip $chipset       # read BIOS internally if possible with selected chipset
    flashrom --programmer internal   --read backup2.rom --chip $chipset
    flashrom --programmer internal   --read backup3.rom --chip $chipset
    sha256sum *.rom                                                           # check BIOS hashes for exactness
    me_cleaner.py --soft-disable backup.rom                                   # clean management engine and overwrite bios inplace
    ifdtool --extract backup.rom                                              # split regions of cleaned bios

    # Rename and move descriptor.bin, gbe.bin, me.bin into 3rdparty/blobs/mainboard/$vendor/$model where
    # $vendor and $model are variable (for example lenovo/t420). Create folders if they do not exist.
    # To test in qemu select model/vendor Emulation/QEMU x86 i440fx/piix4 in nconfig.
    # In real world situations, one might only read and write internally to the bios region.

    flashrom --programmer internal --read  bios.rom --chip $chipset --ifd --image bios
    flashrom --programmer internal --write bios.rom --chip $chipset --ifd --image bios

    make distclean                                                           # clear old configuration
    make clean                                                               # clear old compilation and keep configuration
    make nconfig                                                             # setup configurtion
    cat .config                                                              # check configuration
    make                                                                     # build coreboot
    qemu-system-x86_64 -bios build/coreboot.rom -serial stdio                # test image in qemu

    '
  '';
}
