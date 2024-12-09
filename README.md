# WakaNix

Manage Wakatime using the WakaNix nixosModule and homeManagerModule

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

Either add it to your `NixOS` configuration:
```nix
{
    description = "Your NixOS Configuration";

    outputs = {
        wakanix,
        ...
    }@ inputs: let 
        system = "x86_64-linux";
        in {
            nixosConfigurations.default = nixpkgs.lib.nixosSystem {
                modules = [ 
                    inputs.wakanix.nixosModules.wakanix
                ];
                {
                    programs.wakanix.enable = {
                        # Add options here
                    };
                }
            };
        };
    };
}
```


Or add it to your `homeManager` configuration (can be used as a nixosModule or standalone):
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
            # Example standalone
            homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
                modules = [ 
                    inputs.wakanix.homeManagerModules.wakanix
                ];
                {
                    programs.wakanix.enable = {
                        # Add options here
                    };
                }
            };
        };
    };
}
```

