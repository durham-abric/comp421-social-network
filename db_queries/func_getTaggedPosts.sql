CREATE OR REPLACE FUNCTION  getTaggedPosts( user1 INTEGER, 
                                            tag1 VARCHAR(20))
    RETURNS TABLE(pID INTEGER,
                  postDate TIMESTAMP, 
                  message VARCHAR(500), 
                  poster INTEGER, 
                  page INTEGER, 
                  originalPost INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN  SELECT      *
                FROM        Post
                WHERE       EXISTS( SELECT  * 
                                    FROM    ContainsTag 
                                    WHERE   post = pID 
                                    AND     tag = tag1) 
                AND         isVisible(user1, pID)
                ORDER BY    postDate DESC;
    END@