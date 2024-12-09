{
  lib,
  config,
  ...
}: {
  imports = [../common];

  options.programs.wakanix.configFilePath = lib.mkOption {
    type = lib.types.path;
    description = "Path to .wakatime.cfg";
  };
}
