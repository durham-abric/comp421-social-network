CREATE OR REPLACE PROCEDURE friendTopSuggested(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE today DATE;
        
        SELECT CURRENT_DATE 
        INTO today
        FROM sysibm.sysdummy1;

        INSERT INTO Friends
        SELECT      user1, uID, today
        FROM        TABLE(getSuggestedFriends(user1))
        FETCH       FIRST 10 ROWS ONLY;

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      Friends.userB AS friendedID,
                            User.username AS friendName 
                FROM        Friends
                JOIN        User
                ON          Friends.userB = User.ownID
                WHERE       Friends.sinceWhen = today;

        OPEN cur;


    END@