CREATE OR REPLACE FUNCTION getNewsFeedLikes(user1 INTEGER)
    RETURNS TABLE(  pID INTEGER, 
                    uID INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN  SELECT  pID, uID
                FROM    Like
                WHERE   areFriends(user1, uID) = 1
                AND     isVisible(user1, pID) = 1;
    END@