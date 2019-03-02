CREATE OR REPLACE FUNCTION getSuggestedFriends(user1 INTEGER)
    RETURNS TABLE(uID INTEGER, mutual INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC
        RETURN  SELECT      DISTINCT(userB), 
                            numMutualFriends(user1, userB) AS mutual
                FROM        FriendsOfFriends
                WHERE       userA = user1
                AND NOT     areFriends(user1, userB) = 1
                ORDER BY    mutual DESC;
    END@