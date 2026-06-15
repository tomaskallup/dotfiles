{ ... }:
{
  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon = {
      settings = {
        data-root = "/data/docker";
      };
    };
  };
}
