SELECT eventName, eventDate, location
    FROM EVENT
WHERE numFriendsAttending("placeholder", "placeholder") > 0
AND eventDate > (SELECT current date FROM sysibm.sysdummy1)
ORDER BY numFriendsAttending("placeholder", "placeholder") DESC;