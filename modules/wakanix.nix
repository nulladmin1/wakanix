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
        debug = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable debug (false by default)";
        };
        hide = {
          project = {
            names = lib.mkOption {
              type = 
                with lib.types;
                oneOf [
                  bool
                  list
                ];
              default = false;
              description = "Hide project names";
            };
            folder = lib.mkOption {
              type = 
                with lib.types;
                oneOf [
                  bool
                  list
                ];
              default = false;
              description = "Hide project folders";
            };
          };
        };
          
        extraSettings = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = {};
          description = "Other settings options";
        };
      };
      extraConf = lib.mkOption {
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
        settings =
          {
            api_url = cfg.settings.api.url;
            api_key = cfg.settings.api.key;
          } // cfg.settings.extraSettings;
      } // cfg.extraConf;
    };
}
