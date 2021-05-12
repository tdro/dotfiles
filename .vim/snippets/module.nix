{ pkgs, lib, config, ... }:

let

  service = "";
  cfg = config.services.${service};

in {

  options.services.${service} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable { };
}
