DELIMITER @

CREATE OR REPLACE PROCEDURE getMutualFriends( IN user1 INTEGER, 
                                              IN user2 INTEGER)
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT DISTINCT(USERB) 
                    FROM BIDIRECTIONALFRIENDS AS bdf1
                WHERE EXISTS(SELECT * 
                                FROM BIDIRECTIONALFRIENDS as bdf2 
                            WHERE bdf1.USERA = user1 AND
                                bdf2.USERA = user2 AND
                                bdf1.USERB = bdf2.USERB);

        OPEN cur;

    END@

DELIMITER ;