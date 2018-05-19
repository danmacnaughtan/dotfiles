xautolock -time 5 -locker fuzzy_lock -notify 20 -notifier 'xset dpms force off' &
xautolock -time 10 -locker "systemctl suspend" &
