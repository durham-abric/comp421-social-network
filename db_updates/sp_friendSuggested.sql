CREATE OR REPLACE PROCEDURE friendSuggested(IN user1 INTEGER,
                                            IN top INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE today DATE;
        SELECT today = CURRENT_DATE FROM sysibm.sysdummy1;

        INSERT INTO Friends
        SELECT      user1, uID, today
        FROM        TABLE(getSuggestedFriends(user1))
        LIMIT       top;

    END@