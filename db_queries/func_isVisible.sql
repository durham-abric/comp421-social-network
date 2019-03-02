CREATE OR REPLACE FUNCTION isPostVisible( user1 INTEGER,
                                          post  INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC

      DECLARE visible INTEGER;


      SELECT  (CASE po.privacy
                  WHEN po.privacy LIKE 'private' THEN 0
                  WHEN po.privacy LIKE 'public'  THEN 1
                  WHEN po.privacy LIKE 'friends' THEN areFriends(user1, p.poster)
                  ELSE -1
              END CASE) AS visibility
      FROM Post AS p
      JOIN PageOwner AS po
      ON p.page = po.pageID
      WHERE p.pID = post;

      RETURN visible;

    END@
    