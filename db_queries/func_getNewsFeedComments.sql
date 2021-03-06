CREATE OR REPLACE FUNCTION getNewsFeedComments(user1 INTEGER)
    RETURNS TABLE(  pID INTEGER, 
                    uID INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN  SELECT  post, poster
                FROM    Comment
                WHERE   areFriends(user1, poster) = 1
                AND     isVisible(user1, post) = 1;
    END@