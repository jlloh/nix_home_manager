{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jialong.loh";
  home.homeDirectory = "/Users/jialong.loh";

  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    pkgs.helix
    
    # Wezterm dependencies. 
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

    pkgs.git
    pkgs.delta

    pkgs.fzf

    pkgs.ripgrep

    pkgs.nil

    pkgs.kubectl
    pkgs.kubernetes-helm

    # pkgs.nodePackages_latest.vscode-json-languageserver
    #pkgs.nodePackages_latest.vscode-langservers-extracted

    pkgs.terraform-ls

    pkgs.gitui

    pkgs.hurl

    pkgs.podman
    pkgs.qemu

    pkgs.jq

    pkgs.protols

   # pkgs.nodePackages_latest.vscode-json-languageserver
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    ".config/zellij/layouts/default.kdl".text = ''
    layout {
        pane split_direction="vertical" {
            pane size="70%"
            pane size="30%" split_direction="horizontal" {
                pane
                pane
            }
        }
        pane size=2 borderless=true {
            plugin location="zellij:status-bar"
        }
    }
    '';
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh.enable = true;
  programs.zsh.initExtra = ''eval "$(zellij setup --generate-auto-start zsh)"'';
  programs.zsh.shellAliases = {
    ls = "ls --color";
  };

  # oh-my-zsh configurations
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.theme = "robbyrussell";
  programs.zsh.oh-my-zsh.plugins = ["git" "kubectl" "kubectx"];
  programs.fzf.enable = true;
  
  # zellij
  programs.zellij.enable = true;
  programs.zellij.settings = {
    theme = "default";
  };
  # TODO: Layout for zellij?
  
  # zoxide
  programs.zoxide.enable = true;

  # starship
  programs.starship.enable = true;
  
  # helix configs


  # git configs
  programs.git.enable = true;
  programs.git.delta.enable = true;
  programs.git.delta.options = {
    decorations = {
      commit-decoration-style = "bold yellow box ul";
      file-decoration-style = "none";
      file-style = "bold yellow ul";
    };
    features = "decorations";
    whitespace-error-style = "22 reverse";
  };
  programs.git.aliases = {
    master = "!git checkout master && git pull";
    co = "checkout";
  };
  programs.git.extraConfig = {
    user = {
      email = "jialong.loh@grabtaxi.com";
      name = "Jia Long Loh";
    };
    url = {
      "git@gitlab.myteksi.net:" = {insteadOf = "https://gitlab.myteksi.net";};
    };
    push = {
      autoSetupRemote = true;
    };
  };
  
  # wezterm extra config
  programs.wezterm.enable = true;
  # TODO: How to make sure wezterm takes this config. Also how to make it OS specific
  programs.wezterm.extraConfig = ''
local wezterm = require 'wezterm'
local act = wezterm.action

return {
  mouse_bindings = {
    -- Right click sends "woot" to the terminal
    {
      event = { Down = { streak = 1, button = 'Middle' } },
      mods = 'NONE',
      action = act.PasteFrom 'Clipboard',
    },
  },

  keys = {
    -- paste from the clipboard

    -- { key = 'v', mods = 'CTRL+SHIFT', action = act.PasteFrom 'Clipboard' },

    -- -- paste from the primary selection
    -- { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },

    -- if we swap ctrl and command keys for mac, all ctrl shortcuts get broken
    -- e.g. cmd + w should do what ctrl + w does
    { key = 'w', mods = 'CMD', 
        action = act.SendKey {
          key = 'w',
          mods = 'CTRL'
        } 
    },
    -- start of line in terminal, ctrl + a
    { key = 'a', mods = 'CMD', 
        action = act.SendKey {
          key = 'a',
          mods = 'CTRL'
        } 
    },
    -- end of line in terminal, ctrl + e
    { key = 'e', mods = 'CMD', 
        action = act.SendKey {
          key = 'e',
          mods = 'CTRL'
        } 
    },
    -- ctrl + r for reverse search
    { key = 'r', mods = 'CMD', 
        action = act.SendKey {
          key = 'r',
          mods = 'CTRL'
        } 
    },
    -- ctrl + d for closing things
    { key = 'd', mods = 'CMD', 
        action = act.SendKey {
          key = 'd',
          mods = 'CTRL'
        } 
    },

    -- Helix specific    
    -- comment out in helix, ctrl + c
    { key = 'c', mods = 'CMD', 
        action = act.SendKey {
          key = 'c',
          mods = 'CTRL'
        } 
    },
    { key = 'i', mods = 'CMD', 
        action = act.SendKey {
          key = 'i',
          mods = 'CTRL'
        } 
    },
    { key = 'o', mods = 'CMD', 
        action = act.SendKey {
          key = 'o',
          mods = 'CTRL'
        } 
    },
    { key = 'b', mods = 'CMD', 
        action = act.SendKey {
          key = 'b',
          mods = 'CTRL'
        } 
    },
    { key = 'f', mods = 'CMD', 
        action = act.SendKey {
          key = 'f',
          mods = 'CTRL'
        } 
    },
  },

  color_scheme = "Mariana",
  font = wezterm.font ('Victor Mono', {weight='Bold'}),
  -- font_size = 10.5,
  initial_cols = 150,
  initial_rows = 50,  

  }
  '';

  # Helix
  programs.helix.enable = true;
  # programs.helix.language-server.rust-analyzer.config = {
  #   check = { command = "clippy"; };
  # };
  programs.helix.languages = {
    language-server.rust-analyzer = {
      config = {
        check = { command = "clippy"; };
      };
    };
    # language-server.ruff-lsp = {
    #   command = "ruff-lsp";
    #   config = {
    #     documentFormatting = true;
    #     settings = {
    #       run = "onSave";
    #     };
    #   };
    # };

    language-server.ruff = {
      command = "ruff";
      config = {
        settings = {
          # args = ["--ignore" "E501"];
          args = ["server"];
        };
      };
    };

    # language-server.pyright = {
    #   command = "pyright-langserver";
    #   args = ["--stdio"];
    #   config = {
    #   };
    # };

    language-server.pyright = {
      config = {
        python = {
          analysis = {
            typeCheckingMode = "basic";
          };
        };
      };
    };

    language = [
      {
        name = "rust";
        auto-format = true;
      }

      {
        name = "go";
        auto-format = true;
        workspace-lsp-roots = ["ut-platform" "grab-fraud"];
      }
      {
        name = "python";
        auto-format = true;
        language-servers = ["ruff" "pyright"];
        formatter = {
          command = "black";
          args = ["--quiet" "-"];
        };
      }
      # {
      #   name = "scala";
      #   auto-format = true;
      #   config = {
      #     checkonSave = {
      #       command = "scalafix";
      #     };
      #   };
      # }
      # {
      #   name = "json";
      #   auto-format = true;
      #   language-server = {
      #     command = "vscode-json-language-server";
      #     args = ["--stdio"];
      #   };
      # }
    ];
  };
  programs.helix.settings = {
    theme = "nord";
  };

  # direnv
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
