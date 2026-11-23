local colors = require("themes")
require("keymaps")
require("autostart")

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  -- scale = 1
})

local envs = {
  XCURSOR_SIZE = "16",
  XCURSOR_THEME = os.getenv("HYPR_THEME") == "latte"
    and "catppuccin-mocha-dark-cursors" or "catppuccin-latte-light-cursors",
  QT_QPA_PLATFORMTHEME = "qt6ct",
  QT_QPA_PLATFORM = "wayland",
  QT_STYLE_OVERRIDE = "Breeze",
  XDG_SESSION_DESKTOP = "Hyprland",
  XDG_CURRENT_DESKTOP = "Hyprland",
  XDG_SESSION_TYPE = "wayland",
}

for key, value in pairs(envs) do
  hl.env(key, value)
end

hl.config({
  input = {
    kb_layout = "us",
    ["touchpad.natural_scroll"] = false,
  }
})

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = colors.mauve,
      inactive_border = colors.surface0,
    },
    layout = "dwindle",
    allow_tearing = false
  },
  decoration = {
    rounding = 5,
    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      xray = true,
      ignore_opacity = true,
    }
  },
  -- dwindle = {
  --   pseudotile = true,
  --   preserve_split = true,
  -- },
  misc = {
    force_default_wallpaper = 0,
  },
})

require("animations")
