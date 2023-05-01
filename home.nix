{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jl";
  home.homeDirectory = "/home/jl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.helix
    
    # Wezterm
    pkgs.wezterm
    pkgs.victor-mono
    
    # Zellij
    pkgs.zellij
    
    # Starship
    pkgs.starship
    
    # zsh
    pkgs.zsh
    
    # oh-my-zsh
    pkgs.oh-my-zsh
    
    pkgs.zoxide

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    
    ## Can set configs for helix, wezterm, zellij through this?

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jl/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "hx";
    TEST = "HomeManager";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # oh-my-zsh configurations
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [];
  # programs.zsh.oh-my-zsh.theme = "";
  
  # zellij
  programs.zellij.enable = true;
  
  # zoxide
  programs.zoxide.enable = true;
  
  # helix configs
  
  # wezterm extra config
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
local wezterm = require 'wezterm'
local act = wezterm.action
return {
  keys = {
    -- paste from the clipboard
    { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

    -- paste from the primary selection
    { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
  },
  color_scheme = "Mariana",
  font = wezterm.font ('Victor Mono', {weight='Bold'}),
  font_size = 10.5,
  initial_cols = 200,
  initial_rows = 50,
  }
  '';
}
