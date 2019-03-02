CREATE OR REPLACE FUNCTION numFriendsAttending( user1 INTEGER, 
                                                event INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN  SELECT  COUNT(*) 
                FROM    TABLE(getFriendsAttending(user1, event));
    END@