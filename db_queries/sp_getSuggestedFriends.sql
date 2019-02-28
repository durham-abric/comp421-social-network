CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT USERB
                    FROM (SELECT * 
                            FROM FRIENDSOFFRIENDS as fof
                            WHERE fof.USERA = user1) AS sug
                ORDER BY (SELECT COUNT(*)
                            FROM TABLE(getMutualFriends(sug.USERA, sug.USERB)));
                
        OPEN cur;

    END@