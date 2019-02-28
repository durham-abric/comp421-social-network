CREATE OR REPLACE FUNCTION numFriendsAttending(user1 INTEGER, 
                                            event INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN
            SELECT COUNT(DISTINCT(uid)) 
                FROM GOINGTO AS gt
            WHERE EXISTS(SELECT * 
                            FROM BIDIRECTIONALFRIENDS as bdf 
                        WHERE bdf.USERA = user1 AND
                        bdf.USERB = uid) AND
            eid = event;
    END@