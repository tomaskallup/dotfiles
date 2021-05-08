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
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/armeeh/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lualine\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["material.nvim"] = {
    config = { "\27LJ\1\2d\0\0\2\0\a\0\n4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\4\0%\1\5\0>\0\2\0027\0\6\0>\0\1\1G\0\1\0\bset\rmaterial\frequire\15deep ocean\19material_style\6g\bvim\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
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
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\0026\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\27plugins.nvim-lspconfig\frequire\0" },
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
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\1\2=\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
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
  ["ron.vim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/ron.vim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/rust.vim"
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
  ["vim-teal"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-teal"
  },
  ["vim-virtualenv"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-virtualenv"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  vimwiki = {
    config = { "\27LJ\1\2€\1\0\0\3\0\6\0\v4\0\0\0007\0\1\0002\1\3\0003\2\3\0;\2\1\1:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\14<leader>e\23vimwiki_map_prefix\1\0\1\tpath\25/home/armeeh/vimwiki\17vimwiki_list\6g\bvim\0" },
    loaded = true,
    path = "/home/armeeh/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

time("Defining packer_plugins", false)
-- Config for: nvim-ts-autotag
time("Config for nvim-ts-autotag", true)
try_loadstring("\27LJ\1\2=\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time("Config for nvim-ts-autotag", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time("Config for nvim-treesitter", false)
-- Config for: material.nvim
time("Config for material.nvim", true)
try_loadstring("\27LJ\1\2d\0\0\2\0\a\0\n4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\4\0%\1\5\0>\0\2\0027\0\6\0>\0\1\1G\0\1\0\bset\rmaterial\frequire\15deep ocean\19material_style\6g\bvim\0", "config", "material.nvim")
time("Config for material.nvim", false)
-- Config for: vimwiki
time("Config for vimwiki", true)
try_loadstring("\27LJ\1\2€\1\0\0\3\0\6\0\v4\0\0\0007\0\1\0002\1\3\0003\2\3\0;\2\1\1:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\14<leader>e\23vimwiki_map_prefix\1\0\1\tpath\25/home/armeeh/vimwiki\17vimwiki_list\6g\bvim\0", "config", "vimwiki")
time("Config for vimwiki", false)
-- Config for: vim-rooter
time("Config for vim-rooter", true)
try_loadstring("\27LJ\1\2G\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\4\0\0\n.venv\n.git/\n.vim/\20rooter_patterns\6g\bvim\0", "config", "vim-rooter")
time("Config for vim-rooter", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.nvim-compe\frequire\0", "config", "nvim-compe")
time("Config for nvim-compe", false)
-- Config for: nvim-colorizer.lua
time("Config for nvim-colorizer.lua", true)
try_loadstring("\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time("Config for nvim-colorizer.lua", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lualine\frequire\0", "config", "lualine.nvim")
time("Config for lualine.nvim", false)
-- Config for: telescope.nvim
time("Config for telescope.nvim", true)
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0", "config", "telescope.nvim")
time("Config for telescope.nvim", false)
-- Config for: nvim-dap
time("Config for nvim-dap", true)
try_loadstring("\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.nvim-dap\frequire\0", "config", "nvim-dap")
time("Config for nvim-dap", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
try_loadstring("\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0", "config", "gitsigns.nvim")
time("Config for gitsigns.nvim", false)
-- Config for: nvim-lspconfig
time("Config for nvim-lspconfig", true)
try_loadstring("\27LJ\1\0026\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\27plugins.nvim-lspconfig\frequire\0", "config", "nvim-lspconfig")
time("Config for nvim-lspconfig", false)
-- Config for: vim-plugin-AnsiEsc
time("Config for vim-plugin-AnsiEsc", true)
try_loadstring("\27LJ\1\0021\0\0\2\0\3\0\0054\0\0\0007\0\1\0'\1\1\0:\1\2\0G\0\1\0\20no_cecutil_maps\6g\bvim\0", "config", "vim-plugin-AnsiEsc")
time("Config for vim-plugin-AnsiEsc", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
