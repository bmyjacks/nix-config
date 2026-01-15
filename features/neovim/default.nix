{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "neovim";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      # Useful packages
      home.packages = with pkgs; [
        lua-language-server
        nixd
        stylua
        treefmt

        # Telescope
        ripgrep
        fd

        tree-sitter
      ];

      # Neovim config
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile ./init.lua;
        plugins = with pkgs.vimPlugins; [
          # Theme
          onedark-nvim
          lualine-nvim

          # LSP
          nvim-lspconfig

          # Formatter
          conform-nvim

          # File explorer
          oil-nvim

          # Show git info
          gitsigns-nvim

          # Search
          telescope-nvim
          plenary-nvim
          telescope-fzf-native-nvim

          # Parser
          nvim-treesitter.withAllGrammars

          # Completetion
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          nvim-cmp
          luasnip
          cmp_luasnip

          # direnv
          direnv-vim

          # Wakatime
          vim-wakatime
        ];
      };
    };
  };
}
