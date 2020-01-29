#!/bin/bash

##----------------------------------------------##
## set and show default add				        ##
## for help run without args                    ##
##----------------------------------------------##

function f_getAppList {
	
	apps=$(ls /usr/share/applications/*.desktop)
	user_apps=$(ls /home/dmitry/.local/share/applications/*.desktop)
	snap_apps=$(ls /var/lib/snapd/desktop/applications/*.desktop)
	list=$(echo $apps \
			&& echo $user_apps \
			&& echo $snap_apps)

	menu=$((echo $apps \
			&& echo $user_apps \
			&& echo $snap_apps) | xargs -n1 basename)

	menu_list=$(echo -e $menu | sed -e 's/\.desktop//g' | tr ' ' '\n' | sort -u)
	echo $menu_list
}

function f_findApp {
	
	temp=( $@ )
	name=${temp[0]}
	menu_list=( ${temp[@]:1} )
	
	programm="not found"
	for app in ${menu_list[@]}
	do
		if [[ $app == $name ]]
		then
			#~ echo $app
			programm=$app
		fi
	done
	echo $programm
}

function f_findPossibleApps {
	
	temp=( $@ )
	name=${temp[0]}
	menu_list=( ${temp[@]:1} )
	
	apps=()
	for app in ${menu_list[@]}
	do
		if [[ $app == *${name}* ]]
		then
			#~ echo $app
			apps+=( "$app" )
		fi
	done
	echo ${apps[@]}
}

function f_printList {

	list=( $@ )
	
	for elem in ${list[@]}
	do
		echo $elem
	done
}

function f_getFileType {

	file=$1
	echo `xdg-mime query filetype $file`
}

function f_get {
	
	file=$1
	filetype=$( f_getFileType $file)
	echo "type: $filetype"
	echo "app: " `xdg-mime query default $filetype`
}

function f_set {
	
	file=$1
	app=$2
	menu_list=$( f_getAppList)
	programm=$( f_findApp $app $menu_list)

	if [[ $programm = "not found" ]]
	then
		echo "APP NOT FOUNT"
		echo
		echo "Possible values: "
		apps=$( f_findPossibleApps $app $menu_list)
		f_printList $apps
	else
		filetype=$( f_getFileType $file)
		xdg-mime default $app.desktop $filetype
		f_get $file		
	fi
}


if [[ $# -eq 2 && $1 = "-g" ]]
then
	f_get $2
elif [[ $# -eq 3 && $1 = "-s" ]]
then
	f_set $2 $3
elif [[ $# -eq 1 && $1 == "-a" ]]
then
	f_printList $( f_getAppList)
elif [[ $# -eq 1 && $1 == "-o" ]]
then
	xdg-open $2
else
	echo "Use:"
	echo "	for set new default app: "
	echo "		./default_app -s file app"
	echo "	for get file type and default app: "
	echo "		./default_app -g file"
	echo "	for list apps: "
	echo "		./default_app -a"
	echo "	for open file by default app: "
	echo "		./default_app -o file"
fi
