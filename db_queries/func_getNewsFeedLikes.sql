REATE OR REPLACE FUNCTION getNewsFeedLikes(user1 INTEGER)
    RETURNS TABLE(pID INTEGER, uID INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN  SELECT      l.pID AS pID
                FROM        Like AS l
                JOIN        Post AS p
                            ON l.pID = p.pID
                WHERE       areFriends(user1, l.uID)
                AND         isVisible(user1, p.pID);
    END