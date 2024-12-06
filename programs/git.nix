{...}: {
  programs.git = {
    enable = true;
    userName = "Aryn";
    userEmail = "arynh@protonmail.com";
    ignores = [
      ".DS_STORE"
      ".classpath"
      ".factorypath"
      ".project"
      ".settings"
    ];

    # use a fancy diff tool :3
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        light = false;
      };
    };
  };
}
