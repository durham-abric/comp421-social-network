CREATE OR REPLACE FUNCTION getSuggestedEvents(user1 INTEGER)
    RETURNS TABLE(  eID INTEGER, 
                    eventName VARCHAR(50), 
                    eventDate TIMESTAMP, 
                    location VARCHAR(100),
                    planner INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN  SELECT      *
                FROM        Event
                WHERE       numFriendsAttending(user1, ownID) > 0
                AND         eventDate > (SELECT CURRENT_DATE FROM sysibm.sysdummy1)
                ORDER BY    numFriendsAttending(user1, ownID) DESC;

    END@