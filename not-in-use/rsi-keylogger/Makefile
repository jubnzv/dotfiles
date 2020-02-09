rsi_keylogger:
	# gcc -o rsi_keylogger `pkg-config --libs --cflags libnotify` main.c
	gcc -o rsi_keylogger main.c
install:
	mkdir -p ~/.config/systemd/user/
	mkdir -pv ~/Scripts/
	mkdir -pv ~/Org/Data/
	cp rsi_keylogger_X11.sh ~/Scripts/
	ln -sf $(realpath .config/systemd/user/rsi_keylogger.service) ~/.config/systemd/user/rsi_keylogger.service
	systemctl --user daemon-reload
	systemctl --user enable rsi_keylogger
	systemctl --user start rsi_keylogger
uninstall:
	systemctl --user disable rsi_keylogger
clean:
	rm rsi_keylogger
