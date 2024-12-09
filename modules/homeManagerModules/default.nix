{
  lib,
  config,
  ...
}: {
  imports = [../common];

  options.programs.wakanix.configFilePath = lib.mkOption {
    type = lib.types.path;
    default = config.home.homeDirectory + ".wakatime.cfg";
    description = "Path to .wakatime.cfg";
  };
}
