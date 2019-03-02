CREATE OR REPLACE FUNCTION isPostVisible( user1 INTEGER,
                                          post  INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN

      DECLARE visible INTEGER;

      SELECT  visible = (CASE po.privacy
                            WHEN po.privacy = 'private' THEN 0
                            WHEN po.privacy = 'public'  THEN 1
                            WHEN po.privacy = 'friends' THEN areFriends(user1, p.poster)
                            ELSE -1
                          END)
      FROM Post AS p
      JOIN PageOwner AS po
      ON p.page = po.pageID
      WHERE p.pID = post;

      RETURN visible;

    END@
    