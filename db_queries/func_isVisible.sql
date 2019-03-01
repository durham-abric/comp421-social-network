CREATE OR REPLACE FUNCTION isPostVisible( user1 INTEGER,
                                          post  INTEGER)
    RETURNS BOOLEAN
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
      SELECT CASE 
        WHEN po.privacy = 'private' THEN FALSE
        WHEN po.privacy = 'public'  THEN TRUE
        WHEN po.privacy = 'friends' THEN areFriends(user1, p.poster) 
      FROM Post AS p
      JOIN PageOwner AS po
      ON p.page = po.pageID
      WHERE p.pID = post;
    END@
    