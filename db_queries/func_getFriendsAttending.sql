CREATE OR REPLACE FUNCTION getFriendsAttending( user1 INTEGER, 
                                                event INTEGER)
    RETURNS TABLE(uID INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN  SELECT  DISTINCT(uID) 
                FROM    GoingTo
                WHERE   areFriends(user1, uID) = 1
                AND     eID = event;
    END@