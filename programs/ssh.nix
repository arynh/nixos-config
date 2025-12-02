{ ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks.github = {
      host = "github.com";
      identityFile = "~/.ssh/id_ed25519";
      addKeysToAgent = "yes";
    };
  };
}
