CREATE OR REPLACE FUNCTION getFriendsAttending(user1 INTEGER, 
                                            event INTEGER)
    RETURNS TABLE(friendAttending INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN
            SELECT DISTINCT(uid) 
                FROM GOINGTO AS gt
            WHERE EXISTS(SELECT * 
                            FROM BIDIRECTIONALFRIENDS as bdf 
                        WHERE bdf.USERA = user1 AND
                        bdf.USERB = uid) AND
            eid = event;
    END@