CREATE OR REPLACE PROCEDURE getTaggedPosts( IN user1 INTEGER, 
                                            IN tag1 VARCHAR(20))
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      *
                FROM        Post
                WHERE       EXISTS( SELECT  * 
                                    FROM    ContainsTag 
                                    WHERE   post = pID 
                                    AND     tag = tag1) 
                AND         isVisible(user1, pID) = 1
                ORDER BY    postDate DESC;

        OPEN cur;
    
    END@