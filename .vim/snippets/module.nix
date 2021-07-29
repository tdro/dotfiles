{ pkgs, lib, config, ... }:

let

  service = "";
  cfg = config.services.${service};
  settings = pkgs.formats.json { };

in {

  options.services.${service} = {

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = service;
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = service;
    };

    settings = lib.mkOption {
      type = settings.type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {

    services.${service}.settings = { };

  };
}
