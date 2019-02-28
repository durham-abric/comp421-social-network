CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT *
                    FROM FRIENDSOFFRIENDS as fof
                    CROSS APPLY (SELECT COUNT(*)
                                    FROM TABLE(getMutualFriends(user1, fof.USERB)))
                WHERE fof.USERA = user1;
                
        OPEN cur;

    END@