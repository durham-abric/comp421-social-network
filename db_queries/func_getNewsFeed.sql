CREATE OR REPLACE FUNCTION getNewsFeed(user1 INTEGER)
    RETURNS TABLE(pID INTEGER,
                  postDate TIMESTAMP, 
                  message VARCHAR(500), 
                  poster INTEGER, 
                  page INTEGER, 
                  originalPost INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
      RETURN  SELECT    * 
              FROM      Post
              WHERE     EXISTS(SELECT *
                               FROM   TABLE(getNewsFeedComments(user1)) AS c
                               WHERE  pID = c.pID)
              OR        EXISTS(SELECT *
                               FROM   TABLE(getNewsFeedLikes(user1)) AS l
                               WHERE  pID = l.pID)
              OR        areFriends(user1, poster) = 1
              GROUP BY  pID
              ORDER BY  postDate DESC
              LIMIT     numPosts;
    END@