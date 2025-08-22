{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
                       coreutils
                       vim
                       iterm2
                       google-chrome
                       pulumi
                       # cmake
                       # gcc
                       # openssl
                       uv
                       htop
                       visidata
                       google-cloud-sdk
                       dbeaver-bin
                       git-lfs
                       gemini-cli
                       lazyjj
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  system.keyboard.enableKeyMapping = true;
  fonts.packages = [ pkgs.nerd-fonts.fira-code pkgs.nerd-fonts.droid-sans-mono];
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder._FXShowPosixPathInTitle = true;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Welcome Thomas";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ "nikitabobko/tap/aerospace" "cyberduck" "ghostty" ];
    taps = [ ];
    brews = [ "gh" "libomp" "cmake" "gcc" "llvm" "libssh2"];
    masApps = {
      "Windows App" = 1295203466;
    };
  };
}
