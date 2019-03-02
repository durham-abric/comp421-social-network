CREATE OR REPLACE PROCEDURE getMutualFriends( IN user1 INTEGER, 
                                              IN user2 INTEGER)
    LANGUAGE SQL

    BEGIN
        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT  DISTINCT(userB) 
                FROM    BidirectionalFriends
                WHERE   areFriends(user1, userB) = 1  
                AND     areFriends(user2, userB) = 1;

        OPEN cur;
    END@