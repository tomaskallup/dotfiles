[[ -f ~/.bashrc ]] && source ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" ]]; then
	exec xinit
fi
