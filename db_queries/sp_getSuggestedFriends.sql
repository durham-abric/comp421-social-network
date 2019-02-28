CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT USERB
                    FROM FRIENDSOFFRIENDS as fof
                WHERE fof.USERA = user1
                ORDER BY numMutualFriends(user1, fof.USERB) DESC;
                
        OPEN cur;

    END@