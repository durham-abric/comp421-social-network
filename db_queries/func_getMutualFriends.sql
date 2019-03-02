CREATE OR REPLACE FUNCTION getMutualFriends(user1 INTEGER, 
                                            user2 INTEGER)
    RETURNS TABLE(uID INTEGER)
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN ATOMIC
        RETURN  SELECT  DISTINCT(userB)
                FROM    BidirectionalFriends
                WHERE   areFriends(user1, userB) = 1  
                AND     areFriends(user2, userB) = 1;           
    END@