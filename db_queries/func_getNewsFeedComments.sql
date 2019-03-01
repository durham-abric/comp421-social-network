CREATE OR REPLACE FUNCTION getNewsFeedComments(user1 INTEGER)
    RETURNS TABLE(pID INTEGER, uID INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN  SELECT          c.post AS pID
                FROM            Comments AS c
                JOIN            Post AS p
                                ON c.post = p.pID
                WHERE           areFriends(user1, c.poster)
                AND             isVisible(user1, p.pID);
    END