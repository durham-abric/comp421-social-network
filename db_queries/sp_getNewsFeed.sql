CREATE OR REPLACE PROCEDURE getNewsFeed(IN user1 INTEGER,
                                        IN numPosts INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur as CURSOR WITH RETURN TO CALLER
            FOR SELECT DISTINCT* 
                FROM Post
                WHERE EXISTS(   SELECT *
                                FROM TABLE(getNewsFeedComments(user1) AS c
                                WHERE pID = c.pID))
                OR EXISTS(      SELECT *
                                FROM TABLE(getNewsFeedLikes(user1)) AS l
                                WHERE pID = l.pID)
                OR areFriends(user1, poster))
                ORDER BY postDate DESC
                LIMIT numPosts;

    END@