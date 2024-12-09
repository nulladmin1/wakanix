# https://github.com/wakatime/wakatime-cli/blob/develop/USAGE.md
{
  lib,
  config,
  ...
}: {
  options = {
    programs.wakanix = {
      enable = lib.mkEnableOption "Enable declarative configuration for wakatime using wakanix";

      settings = {
        api = {
          url = lib.mkOption {
            type = lib.types.str;
            default = "https://api.wakatime.com/api/v1";
            description = "The url for Wakatime";
          };

          key = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = "The key for Wakatime";
          };
        };
      };

      extraSettings = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
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
        settings =
          {
            api_url = cfg.settings.api.url;
            api_key = cfg.settings.api.key;
          }
          // cfg.extraSettings;
      };
    };
}
