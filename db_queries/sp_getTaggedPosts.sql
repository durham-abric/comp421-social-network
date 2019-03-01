CREATE OR REPLACE PROCEDURE getTaggedPosts( IN user1 INTEGER, 
                                            IN tag1 VARCHAR(20))
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      p.*
                FROM        Post as p
                            JOIN (SELECT ownID, privacy FROM user) as u
                            ON p.poster = u.ownID
                WHERE       EXISTS( SELECT * 
                                FROM    ContainsTag 
                                WHERE   post = p.pID 
                                AND     tag = tag1) 
                AND         (u.privacy = "public" 
                             OR (u.privacy = "friends"  
                                AND EXISTS( SELECT  * 
                                            FROM    BidirectionalFriends
                                            WHERE   USERA = user1
                                            AND     USERB = u.ownID)
                                )   
                            )
                ORDER BY    postDate DESC;

        OPEN cur;
    
    END@