CREATE OR REPLACE FUNCTION areFriends(  user1 INTEGER,
                                        user2 INTEGER)
    RETURNS BOOLEAN
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN SELECT EXISTS(   SELECT * 
                                FROM BidirectionalFriends
                                WHERE userA = user1
                                AND userB = user2);
    END @