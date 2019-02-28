CREATE OR REPLACE PROCEDURE getSuggestedEvents(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT eid, eventName, eventDate, location
                    FROM EVENT
                WHERE numFriendsAttending(user1, eid) > 0
                AND eventDate > (SELECT current date FROM sysibm.sysdummy1)
                ORDER BY numFriendsAttending(user1, eid) DESC;
        
        OPEN cur;
    
    END@