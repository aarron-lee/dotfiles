#!/bin/bash

# find search strings with xinput --list
TOUCHPAD_STR="Touchpad"
TOUCHSCREEN_STR="ELAN9008:00"


read TouchpadId <<< $( xinput --list | grep -i "${TOUCHPAD_STR}" | grep -vw 'Stylus' | grep -o 'id=[0-9]*' | sed 's/id=//' )
read TouchscreenId <<< $( xinput --list | grep -i "${TOUCHSCREEN_STR}" | grep -vw 'Stylus' | grep -o 'id=[0-9]*' | sed 's/id=//' )

echo "TouchpadId = $TouchpadId"
echo "TouchscreenId = $TouchscreenId"

state=$( xinput list-props "$TouchpadId" | grep "Device Enabled" | grep -o "[01]$" )

PRINT_TEXT="Touchpad (ID $TouchpadId) &amp; Touchscreen (ID $TouchscreenId) "

if [ "$state" -eq '1' ];then
    xinput --disable "$TouchpadId"
    xinput --disable "$TouchscreenId"
else
    xinput --enable "$TouchpadId"
    xinput --enable "$TouchscreenId"
fi
