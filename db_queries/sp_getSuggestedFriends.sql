CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT fof.USERB
                    FROM FRIENDSOFFRIENDS as fof
                WHERE fof.USERA = user1
                ORDER BY (SELECT COUNT(*)
                            FROM TABLE(getMutualFriends(user1, fof.USERB)));
       
        OPEN cur;

    END@