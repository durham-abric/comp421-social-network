CREATE OR REPLACE PROCEDURE getNewsFeed(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT DISTINCT* 
                FROM Post
                WHERE EXISTS(   SELECT *
                                FROM TABLE(getNewsFeedComments(user1)) AS c
                                WHERE pID = c.pID)
                OR EXISTS(      SELECT *
                                FROM TABLE(getNewsFeedLikes(user1)) AS l
                                WHERE pID = l.pID)
                OR areFriends(user1, poster) = 1
                ORDER BY postDate DESC
                FETCH FIRST 100 ROWS ONLY;
        
        OPEN cur;

    END@