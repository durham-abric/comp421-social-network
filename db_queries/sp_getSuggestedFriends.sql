DELIMITER @

CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT USERB, COUNT(TABLE(getMutualFriends(user1, USERB))) AS numMutual
                    FROM FRIENDSOFFRIENDS
                WHERE USERA = user1
                ORDER BY numMutual DESC;
        
        OPEN cur;

    END@

DELIMITER ;