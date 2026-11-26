if status is-interactive
    if type -q starship
        starship init fish | source
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if test (tty) = /dev/tty1; and not set -q WAYLAND_DISPLAY; and not set -q DISPLAY; and not set -q SSH_CONNECTION
        exec Hyprland
    end
end
function docker-up
    sudo systemctl start docker.service
end
function docker-down
    sudo systemctl stop docker.socket docker.service
end
function ollama-up
    sudo systemctl start ollama.service
end
function ollama-down
    sudo systemctl stop ollama.service
end

# Fixed grayscale syntax, overriding saved universal colors.
if status is-interactive
    set -g fish_color_normal white
    set -g fish_color_command white
    set -g fish_color_keyword white --bold
    set -g fish_color_quote b8b8b8
    set -g fish_color_redirection d0d0d0
    set -g fish_color_end aaaaaa
    set -g fish_color_error ffffff --bold --underline
    set -g fish_color_param d0d0d0
    set -g fish_color_comment 888888
    set -g fish_color_selection white --background=555555
    set -g fish_color_search_match white --background=555555
    set -g fish_color_operator cccccc
    set -g fish_color_escape dddddd
    set -g fish_color_autosuggestion 777777
    set -g fish_color_valid_path --underline
    set -g fish_color_option c0c0c0
    set -g fish_color_cancel ffffff
    set -g fish_color_cwd white
    set -g fish_color_user white
    set -g fish_color_host white
    set -g fish_color_status white --bold
    set -g fish_pager_color_prefix white --bold
    set -g fish_pager_color_completion d0d0d0
    set -g fish_pager_color_description 999999
    set -g fish_pager_color_selected_background --background=444444
end
