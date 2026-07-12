if status is-interactive
# Commands to run in interactive sessions can go here
alias cbonsai 'cbonsai --screensaver --wait=1'
alias ls 'lsd -a'
alias neofetch 'sh /home/okama/.config/fish/pokemon.sh'
set -U fish_color_autosuggestion bfbfbf

sh /home/okama/.config/fish/pokemon.sh

function fish_prompt
    printf '  '
    printf (prompt_pwd) 
    printf ' > '
end

end
