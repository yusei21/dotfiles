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
