{...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks.github = {
      host = "github.com";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
}
