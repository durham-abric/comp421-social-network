CREATE OR REPLACE PROCEDURE friendSuggested(IN user1 INTEGER,
                                            IN top INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE today DATE;
        
        SELECT CURRENT_DATE 
        INTO today
        FROM sysibm.sysdummy1;

        INSERT INTO Friends
        SELECT      user1, uID, today
        FROM        TABLE(getSuggestedFriends(user1))
        LIMIT       top;

    END@