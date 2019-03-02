CREATE OR REPLACE PROCEDURE getSuggestedEvents(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      *
                FROM        Event
                WHERE       numFriendsAttending(user1, ownID) > 0 
                            AND eventDate > (SELECT CURRENT_DATE 
                                             FROM sysibm.sysdummy1)
                ORDER BY    numFriendsAttending(user1, ownID) DESC;
        
        OPEN cur;
    
    END@