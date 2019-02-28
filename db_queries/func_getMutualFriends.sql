CREATE OR REPLACE FUNCTION getMutualFriends(user1 INTEGER, 
                                            user2 INTEGER)
    RETURNS TABLE(mutualFriend INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION
    BEGIN
        RETURN
            SELECT DISTINCT(USERB) 
                FROM BIDIRECTIONALFRIENDS AS bdf1
            WHERE EXISTS(SELECT * 
                            FROM BIDIRECTIONALFRIENDS as bdf2 
                        WHERE bdf1.USERA = user1 AND
                            bdf2.USERA = user2 AND
                            bdf1.USERB = bdf2.USERB);
    END@