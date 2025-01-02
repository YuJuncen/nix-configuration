-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("IBM Plex Mono")
config.font_size = 10.0
config.keys = {
    {
        key = 'd',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'd',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = '[', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Prev'
    },
    {
        key = ']', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Next'
    },
    {
        key = 'Enter', mods = 'CMD|SHIFT', action = wezterm.action.TogglePaneZoomState
    },
    {
        key = 'x', mods = 'ALT', action = wezterm.action.ActivateCommandPalette
    },
{
        key = 'r', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|DOMAINS' }
    }
}
config.enable_scroll_bar = true
config.scrollback_lines = 20000
config.mouse_bindings = {
    { event = { Down = { streak = 4, button = 'Left' } }, mods = 'NONE', action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone', }
}

config.ssh_domains = wezterm.default_ssh_domains()
config.window_frame = {
    font = wezterm.font { family = 'Jetbrains Mono', weight = 'Bold' },
    font_size = 10.0,
}

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local title = tab.tab_title
    local fullscreen_ind = ""

    if #title == 0 then
        title = string.format("#%d", tab.tab_id)
    end

    if pane.is_zoomed then
        fullscreen_ind = wezterm.nerdfonts.md_fullscreen .. ' '
    end


    local idx = string.format("%d) ", tab.tab_index + 1)
    local domain = string.format("[%s]", pane.domain_name)

    return {
        {Text = fullscreen_ind},
        {Text = idx},
        {Text = title},
        {Text = domain},
    }
  end
)

-- and finally, return the configuration to wezterm
return config

