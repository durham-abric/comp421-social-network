CREATE OR REPLACE FUNCTION areFriends(  user1 INTEGER,
                                        user2 INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN  SELECT  CASE
                            WHEN COUNT(*) > 0 THEN 1
                            ELSE 0
                        END CASE
                FROM BidirectionalFriends 
                WHERE userA = user1
                AND userB = user2;
    END@