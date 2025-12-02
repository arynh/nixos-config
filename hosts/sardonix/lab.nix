{ config, ... }:
{
  # Networking
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  # === Caddy ===
  services.caddy = {
    enable = true;

    virtualHosts."media.{$PUBLIC_DOMAIN}".extraConfig = ''
      reverse_proxy http://localhost:8096
    '';

    virtualHosts."photos.{$PUBLIC_DOMAIN}".extraConfig = ''
      reverse_proxy http://localhost:2283
    '';
  };

  sops.secrets.caddyEnv = {
    owner = "caddy";
    restartUnits = [ "caddy.service" ];
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = [ config.sops.secrets.caddyEnv.path ];

  # === Jellyfin ===
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  sops.secrets."samba/aryn" = { };
  fileSystems."/mnt/media" = {
    device = "//iselda.local/media";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        secrets_path = config.sops.secrets."samba/aryn".path;
      in
      [ "${automount_opts},credentials=${secrets_path}" ];
  };

  # === Immich ===
  services.immich = {
    enable = true;
    port = 2283;
    openFirewall = true;
    mediaLocation = "/mnt/photos/immich";
    accelerationDevices = null;
    database.enableVectors = false;
    secretsFile = config.sops.secrets.immich.path;
  };
  sops.secrets.immich = {
    owner = "immich";
    restartUnits = [ "system-immich.slice" ];
  };

  users.users.immich = {
    uid = 3002;
    extraGroups = [
      "video"
      "render"
    ];
  };

  sops.secrets."samba/immich" = { };
  fileSystems."/mnt/photos" = {
    device = "//iselda.local/photos";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        secrets_path = config.sops.secrets."samba/immich".path;
        uid = toString config.users.users.immich.uid;
      in
      [
        "${automount_opts},credentials=${secrets_path},uid=${uid}"
      ];
  };
}
