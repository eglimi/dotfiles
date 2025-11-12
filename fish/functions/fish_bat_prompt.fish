function fish_bat_prompt
    if test -f /sys/class/power_supply/BAT0/capacity
        set battery_level (cat /sys/class/power_supply/BAT0/capacity)
        if test $battery_level -lt 10
            set_color red
            printf "(BAT: %d%%) " $battery_level
            set_color normal
        end
    end

end
