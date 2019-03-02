CREATE OR REPLACE PROCEDURE tagPostsOnPage( IN pageID INTEGER,
                                            IN tag VARCHAR(20))
    LANGUAGE SQL

    BEGIN
      
        INSERT INTO ContainsTag
        SELECT      pID, tag
        FROM        Post
        WHERE       page = pageID
        AND         EXISTS( SELECT  * 
                            FROM    Tag 
                            WHERE   tName = tag)

    END@