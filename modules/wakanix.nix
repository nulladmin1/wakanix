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
        api_url = lib.mkOption {
          type = lib.types.str;
          default = "https://api.wakatime.com/api/v1";
          description = "The url for Wakatime";
        };

        api_key = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "The key for Wakatime";
        };
        debug = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable debug (false by default)";
        };

        hide_file_names = lib.mkOption {
          type = 
            with lib.types;
            oneOf [
              bool
              list
            ];
          default = false;
          description = "Obfuscate filenames. Will not send file names to api.";
        };

        hide_project_names = lib.mkOption {
          type = 
            with lib.types;
            oneOf [
              bool
              list
            ];
          default = false;
          description = ''Obfuscate project names. 
                          When a project folder is detected instead of using the folder name as the project, 
                          a .wakatime-project file is created with a random project name.'';
        };

        hide_branch_names = lib.mkOption {
          type = 
            with lib.types;
            oneOf [
              bool
              list
            ];
          default = false;
          description = ¨Obfuscate branch names. Will not send revision control branch names to api.¨;
        };
        
        hide_project_folder = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Hide project folder";
        };
        
      };
      extraSettings = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
        description = "Other settings options";
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
        settings = cfg.settings // cfg.extraSettings;
      } // cfg.extraConf;
    };
}
