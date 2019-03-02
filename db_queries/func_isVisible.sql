CREATE OR REPLACE FUNCTION isPostVisible( user1 INTEGER,
                                          post  INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
      RETURN  SELECT  (CASE po.privacy
                        WHEN 'private' THEN 0
                        WHEN 'public'  THEN 1
                        WHEN 'friends' THEN areFriends(user1, p.poster)
                        ELSE -1
                      END) AS visible
              FROM Post AS p
              JOIN PageOwner AS po
              ON p.page = po.pageID
              WHERE p.pID = post;
    END@
    