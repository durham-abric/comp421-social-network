CREATE OR REPLACE PROCEDURE getTaggedPosts(IN user1 INTEGER, 
                                            IN tag VARCHAR(20))
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT *
                    FROM POST
                WHERE EXISTS(SELECT *
                                FROM CONTAINSTAG
                            WHERE CONTAINSTAG.post = POST.pID AND
                            CONTAINSTAG.tag = tag) AND
                (POST.privacy = "public" OR
                (POST.privacy = "friends" AND 
                    EXISTS (SELECT * 
                                FROM BIDIRECTIONALFRIENDS
                            WHERE USERA = user1 AND
                            USERB = POST.poster)))
                ORDER BY POST.postDate DESC;

        OPEN cur;
    
    END@