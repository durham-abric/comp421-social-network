CREATE OR REPLACE FUNCTION areFriends(  user1 INTEGER,
                                        user2 INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN  SELECT  CASE
                            WHEN COUNT(*) > 0 THEN 1
                            WHEN COUNT(*) = 0 THEN 0
                            ELSE -1
                        END
                FROM BidirectionalFriends
                WHERE userA = user1 AND userB = user2;
    END @