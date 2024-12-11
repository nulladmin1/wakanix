# https://github.com/wakatime/wakatime-cli/blob/develop/USAGE.md
{
  lib,
  config,
  ...
}: {
  options = {
    programs.wakanix = {
      enable = lib.mkEnableOption "Enable declarative configuration for wakatime using wakanix";

      configFilePath = lib.mkOption {
        type = lib.types.path;
        default = config.home.homeDirectory + "/.wakatime.cfg";
        description = "Path to .wakatime.cfg";
      };

      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {
          debug = false;
          api_url = "https://api.wakatime.com/api/v1";
          heartbeat_rate_limit_seconds = 120;
        };
        description = "Options for the settings table";
      };

      config = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
        description = "Other configuration options";
      };
    };
  };

  config = let
    cfg = config.programs.wakanix;
  in
    lib.mkIf cfg.enable {
      home.file."${cfg.configFilePath}".text = lib.generators.toINI {} {
        settings = cfg.settings
      } // cfg.extraConf;
    };
}
