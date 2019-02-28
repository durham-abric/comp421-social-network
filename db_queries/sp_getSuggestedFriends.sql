CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT USERB
                    FROM (SELECT * 
                            FROM FRIENDSOFFRIENDS as fof
                            WHERE USERA = user1
                            ORDER BY (SELECT COUNT(*)
                                        FROM TABLE(getMutualFriends(USERA, USERB))));
                
        OPEN cur;

    END@