echo '{ "version": 1 }'
echo '['
echo '[]'

while true; do
    current_time=$(date "+%I:%M")
    battery_charge=$(upower --show-info "$(upower --enumerate | grep 'BAT')" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
    battery_status=$(upower --show-info "$(upower --enumerate | grep 'BAT')" | grep -E "state" | awk '{print $2}')
    res=$(ping -c 1 -q -W 2 google.com | grep -c '1 packets transmitted, 1 received, 0% packet loss')

    if [ "$res" -eq 1 ]; then
        wifi=' '
    else
        wifi='󰊠 '
    fi

    COL="#FFA500"
    if [ "$battery_status" = "discharging" ]; then
        if [ "$battery_charge" -lt 15 ]; then
            play -n -c1 synth .3 sin 667 &>/dev/null
            COL="#8B0000"
        elif [ "$battery_charge" -lt 99 ]; then
            COL="#90EE90"
        fi
        battery_pluggedin='  '
    else
        if [ "$battery_charge" -lt 99 ]; then
            COL="#90EE90"
        elif [ "$battery_charge" -eq 100 ]; then
            play -n -c1 synth .3 sin 667 &>/dev/null
            COL="#90EE90"
        fi

        battery_pluggedin=' '
    fi
    echo ",[{\"name\":\"wifi\",\"full_text\":\" $wifi \"}, \
        {\"name\":\"charging\",\"full_text\":\" $battery_pluggedin\",\"separator\":false}, \
            {\"name\":\"charge\",\"full_text\":\"$battery_charge% \",\"color\":\"$COL\"}, \
                {\"name\":\"time\",\"full_text\":\" $current_time\"}]"
    sleep 30
done
