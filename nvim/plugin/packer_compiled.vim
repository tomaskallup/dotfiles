" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  arcolors = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/arcolors"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.nvim-compe\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.nvim-dap\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.lsp-config\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plantuml-syntax"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/plantuml-syntax"
  },
  playground = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  taskwiki = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/taskwiki"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-bbye"
  },
  ["vim-plugin-AnsiEsc"] = {
    config = { "\27LJ\1\0021\0\0\2\0\3\0\0054\0\0\0007\0\1\0'\1\1\0:\1\2\0G\0\1\0\20no_cecutil_maps\6g\bvim\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-plugin-AnsiEsc"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\1\2G\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\4\0\0\n.venv\n.git/\n.vim/\20rooter_patterns\6g\bvim\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-taskwarrior"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-taskwarrior"
  },
  ["vim-virtualenv"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-virtualenv"
  },
  vimwiki = {
    config = { "\27LJ\1\2€\1\0\0\3\0\6\0\v4\0\0\0007\0\1\0002\1\3\0003\2\3\0;\2\1\1:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\14<leader>e\23vimwiki_map_prefix\1\0\1\tpath\25/home/armeeh/vimwiki\17vimwiki_list\6g\bvim\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

-- Config for: nvim-lspconfig
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.lsp-config\frequire\0", "config", "nvim-lspconfig")
-- Config for: vimwiki
try_loadstring("\27LJ\1\2€\1\0\0\3\0\6\0\v4\0\0\0007\0\1\0002\1\3\0003\2\3\0;\2\1\1:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\14<leader>e\23vimwiki_map_prefix\1\0\1\tpath\25/home/armeeh/vimwiki\17vimwiki_list\6g\bvim\0", "config", "vimwiki")
-- Config for: vim-rooter
try_loadstring("\27LJ\1\2G\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\4\0\0\n.venv\n.git/\n.vim/\20rooter_patterns\6g\bvim\0", "config", "vim-rooter")
-- Config for: nvim-compe
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.nvim-compe\frequire\0", "config", "nvim-compe")
-- Config for: nvim-dap
try_loadstring("\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.nvim-dap\frequire\0", "config", "nvim-dap")
-- Config for: gitsigns.nvim
try_loadstring("\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0", "config", "gitsigns.nvim")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
-- Config for: telescope.nvim
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0", "config", "telescope.nvim")
-- Config for: vim-plugin-AnsiEsc
try_loadstring("\27LJ\1\0021\0\0\2\0\3\0\0054\0\0\0007\0\1\0'\1\1\0:\1\2\0G\0\1\0\20no_cecutil_maps\6g\bvim\0", "config", "vim-plugin-AnsiEsc")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
