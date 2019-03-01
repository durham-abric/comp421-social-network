CREATE OR REPLACE PROCEDURE tagPostsOnPage( IN pageID INTEGER,
                                            IN tag VARCHAR(20))
    LANGUAGE SQL

    BEGIN
      
        INSERT INTO ContainsTag
        SELECT      pID, tag
        FROM        Posts
        WHERE       page = pageID
        AND         EXISTS( SELECT  * 
                            FROM    Tag 
                            WHERE   tName = tag)

    END@