#!/bin/sh

ACTION=`zenity --width=90 --height=181 --list --radiolist --text="Select Action" --title="Logout" --column "Choice" --column "Action" TRUE Shutdown FALSE Reboot FALSE Suspend FALSE Lock`

if [ -n "${ACTION}" ];then
  case $ACTION in
  Shutdown)
    zenity --question --text "Are you sure you want to halt?" &&  gksudo 'systemctl poweroff'
    ;;
  Reboot)
    zenity --question --text "Are you sure you want to reboot?" && gksudo 'systemctl reboot'
    ;;
  Suspend)
	killall -q dmenu
	i3lock -d -u -p default -i ~/.config/awesome/themes/default/default_s1280x800.png > /dev/null 2>&1
    systemctl suspend
    ;;
  Lock)
	killall -q dmenu
    i3lock -d -u -p default -i ~/.config/awesome/themes/default/default_s1280x800.png > /dev/null 2>&1
    ;;
  esac
fi
