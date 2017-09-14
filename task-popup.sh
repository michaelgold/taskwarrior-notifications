#!/bin/bash
# found this code on http://taskwarrior.org/projects/1/wiki/Export-htmlpy
# For cron: */30 * * * * DISPLAY=:0.0 /home/User/configs/TaskNotify.sh
# Requires linux with notify-send and canberra-gtk-play which are default on Ubuntu

num=`task active | wc -l`

if [ $num -gt "1" ]
  then

    #notify-send "Active Tasks" "`task active | tail -n +3 | head -n -1`" 
    #canberra-gtk-play --file=/usr/share/sounds/gnome/default/alerts/drip.ogg
    id_list="$(task +ACTIVE _ids)"
    id_list="${id_list//$'\n'/' '}"



    IFS=' ' read -r -a ids <<< "$id_list"
    for i in "${ids[@]}"
    	do
		notify-send "<b>$(task _get $i.id) - $(task _get $i.tags)</b>\n$(task _get $i.description)\n$(task _get $i.project)"
		sleep 0.35
	done
	
 
		
		#notify-send "$(task _get `task +ACTIVE ids`.id) - $(task _get `task +ACTIVE ids`.description)\n$(task _get `task +ACTIVE ids`.project)"
  else
    notify-send "No Active Tasks"  
    #canberra-gtk-play --file=/usr/share/sounds/ubuntu/stereo/dialog-question.ogg
fi


