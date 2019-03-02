CREATE OR REPLACE FUNCTION getSuggestedFriends(user1 INTEGER)
    RETURNS TABLE(uID INTEGER)
    LANGUAGE SQL

    BEGIN 
        RETURN  SELECT      userB
                FROM        FriendsOfFriends
                WHERE       userA = user1
                AND NOT     areFriends(user1, userB) = 1
                ORDER BY    numMutualFriends(user1, userB) DESC;
    END@