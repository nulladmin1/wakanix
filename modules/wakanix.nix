# https://github.com/wakatime/wakatime-cli/blob/develop/USAGE.md
{
  lib,
  config,
  ...
}: {
  options = {
    programs.wakanix = {
      enable = lib.mkEnableOption "Enable declarative configuration for wakatime using WakaNix";

      configFilePath = lib.mkOption {
        type = lib.types.path;
        default = config.home.homeDirectory + "/.wakatime.cfg";
        description = "Path to .wakatime.cfg";
      };

      envApiKey = lib.mkOption {
        type = with lib.types; oneOf [bool str];
        default = false;
        description = "Enable using $WAKATIME_API_KEY to set api key. True enables it and uses the one in the settings, and str uses that as the var.";
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

      generatedConfigFileString = let
        cfg = config.programs.wakanix;
      in
        lib.generators.toINI {} ({inherit (cfg) settings;} // cfg.config);
    };
  };

  config = let
    cfg = config.programs.wakanix;
  in
    lib.mkIf cfg.enable {
      home.file."${cfg.configFilePath}".text = cfg.generatedConfigFileString;

      home.sessionVariables = lib.attrsets.optionalAttrs (builtins.isString cfg.envApiKey) {
        "WAKATIME_API_KEY" = cfg.envApiKey;
      };
    };
}
