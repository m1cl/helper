#!/bin/bash                                                                                                            
#
# This script does this:
# launch an app if it isn't launched yet,
# focus the app if it is launched but not focused,
# minimize the app if it is focused.
#
# by desgua - 2012/04/29
# modified by olds22 - 2012/09/16
#  - customized to accept a parameter
#  - made special exception to get it working with terminator


# First let's check if the needed tools are installed:

tool1=$(which xdotool)
tool2=$(which wmctrl)

if [ -z $tool1 ]; then
  echo "Xdotool is needed, do you want to install it now? [Y/n]"
  read a
  if [[ $a == "Y" || $a == "y" || $a = "" ]]; then
    # TODO add function to check which distro is running on the machine 
    # sudo apt-get install xdotool
    sudo pacman -S xdotool
  else
    echo "Exiting then..."
    exit 1
  fi
fi

if [ -z $tool2 ]; then
  echo "Wmctrl is needed, do you want to install it now? [Y/n]"
  read a
  if [[ $a == "Y" || $a == "y" || $a = "" ]]; then
    # TODO: same 
    # sudo apt-get install wmctrl
    sudo pacman -S wmctrl
  else
    echo "Exiting then..."
    exit 1
  fi
fi


# check if we're trying to use an app that needs a special process name
# (because it runs multiple processes and/or under a different name)
# TODO change hard coded app description 
# app=$1
app=$1
if [[ $app == '' ]]; then
  process_name=/bin/terminator
else
  process_name=$app
fi

# Check if the app is running (in this case $process_name)

#pid=$(pidof $process_name) # pidof didn't work for terminator
pid=$(pgrep -f $process_name)

# If it isn't launched, then launch

if [ -z $pid ]; then
  $app

else

  # If it is launched then check if it is focused

  foc=$(xdotool getactivewindow getwindowpid)

  if [[ $pid == $foc ]]; then

    # if it is focused, then minimize
    xdotool getactivewindow windowminimize
  else
    # if it isn't focused then get focus
    wmctrl -x -R $app
  fi
fi

exit 0

