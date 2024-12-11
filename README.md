# WakaNix

Manage Wakatime using the WakaNix homeManagerModule

## Usage

### Using `flakes`:

Add `WakaNix` to your inputs:

```nix
{
  description = "Your NixOS Configuration";

  inputs = {
    wakanix = {
      url = "github:nulladmin1/wakanix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```
Add it to your `homeManager` configuration (can be used as a nixosModule or standalone):
```nix
{
  description = "Your NixOS Configuration";

  outputs = {
    home-manager,
    wakanix,
    ...
  }@ inputs: let 
    system = "x86_64-linux";
    in {
      # Example standalone configuration
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        modules = [ 
          inputs.wakanix.homeManagerModules.wakanix
            
          {
            programs.wakanix = {
              # Add options here
              };
          }
        ];
      };
    };
};
}
```

## Options:

