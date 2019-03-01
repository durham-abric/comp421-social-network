CREATE OR REPLACE PROCEDURE getTaggedPosts( IN user1 INTEGER, 
                                            IN tag1 VARCHAR(20))
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      *
                FROM        Post as p
                WHERE       EXISTS( SELECT * 
                                FROM    ContainsTag 
                                WHERE   post = p.pID 
                                AND     tag = tag1) 
                AND         (privacy = "public" 
                             OR (privacy = "friends"  
                                AND EXISTS( SELECT  * 
                                            FROM    BidirectionalFriends
                                            WHERE   USERA = user1
                                            AND     USERB = p.poster)
                                )   
                            )
                ORDER BY    postDate DESC;

        OPEN cur;
    
    END@