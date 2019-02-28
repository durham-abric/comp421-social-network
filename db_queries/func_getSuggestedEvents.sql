CREATE OR REPLACE FUNCTION getSuggestedEvents(user1 INTEGER)
    RETURNS TABLE(eig INTEGER, 
                eventName VARCHAR(50), 
                eventDate TIMESTAMP, 
                location VARCHAR(100))
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN SELECT eid, eventName, eventDate, location
                    FROM EVENT AS ev
                WHERE numFriendsAttending(user1, ev.eid) > 0
                AND eventDate > (SELECT current date FROM sysibm.sysdummy1)
                ORDER BY numFriendsAttending(user1, eid) DESC;

    END@