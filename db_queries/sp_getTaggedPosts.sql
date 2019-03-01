CREATE OR REPLACE PROCEDURE getTaggedPosts( IN user1 INTEGER, 
                                            IN tag1 VARCHAR(20))
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      p.*
                FROM        Post as p
                            LEFT JOIN PageOwner as po
                            ON p.poster = po.ownID
                WHERE       EXISTS( SELECT  * 
                                    FROM    ContainsTag 
                                    WHERE   post = p.pID 
                                    AND     tag = tag1) 
                AND         (po.privacy = "public" 
                             OR (po.privacy = "friends"  
                                AND EXISTS( SELECT  * 
                                            FROM    BidirectionalFriends
                                            WHERE   userA = user1
                                            AND     userB = po.ownID)
                                )   
                            )
                ORDER BY    p.postDate DESC;

        OPEN cur;
    
    END@