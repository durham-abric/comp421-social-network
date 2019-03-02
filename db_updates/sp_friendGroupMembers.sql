CREATE OR REPLACE PROCEDURE friendGroupMembers( IN user1 INTEGER,
                                                IN group INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE today DATE;
        
        SELECT CURRENT_DATE 
        INTO today
        FROM sysibm.sysdummy1;

        INSERT INTO Friends
        SELECT      user1, uID, today
        FROM        MemberOf
        WHERE       gID = group
        AND NOT     areFriends(user1, uID) = 1;

    END@