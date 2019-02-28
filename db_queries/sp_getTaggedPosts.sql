CREATE OR REPLACE PROCEDURE getTaggedPosts(IN user1 INTEGER, 
                                            IN tag VARCHAR(20))
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT *
                    FROM POST
                WHERE EXISTS(SELECT *
                                FROM CONTAINSTAG
                            WHERE CONTAINSTAG.post - POST.pid AND
                            CONTAINSTAG.tag = "placeholder") AND
                (POST.privacy = "public" OR
                (POST.privacy = "friends" AND 
                EXISTS (SELECT * 
                            FROM BIDIRECTIONALFRIENDS
                        WHERE USERA = "placeholder")))
                ORDER BY POST.postDate DESC;

        OPEN cur;
    
    END@