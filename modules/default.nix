{self, ...}: {
  wakanix = import ./wakanix.nix;
  default = self.wakanix;
}
