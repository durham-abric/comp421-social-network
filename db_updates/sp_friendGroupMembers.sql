INSERT INTO FRIENDS
SELECT "placeholder", uid, (SELECT current date FROM sysibm.sysdummy1)
    FROM MEMBEROF
WHERE NOT EXISTS(SELECT *
                    FROM BIDIRECTIONALFRIENDS as bdf
                WHERE USERA = "placeholder" AND
                USERB = uid)
AND EXISTS( SELECT *
                FROM MEMBEROF AS mo
            WHERE mo.uid = uid AND
            mo.gid = (SELECT ownID FROM GROUP WHERE groupName = "placeholder"));