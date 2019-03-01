CREATE OR REPLACE FUNCTION getSuggestedFriends(user1 INTEGER)
    RETURNS TABLE(uID INTEGER)
    LANGUAGE SQL

    BEGIN 

        RETURN  SELECT      userB AS uID
                FROM        FriendsOfFriends
                WHERE       userA = user1
                AND NOT     areFriends(user1, userB)
                ORDER BY    numMutualFriends(user1, userB) DESC;

    END@