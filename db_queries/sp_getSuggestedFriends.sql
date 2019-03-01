CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN 

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      userB AS suggested
                FROM        FriendsOfFriends
                WHERE       userA = user1
                AND NOT     areFriends(user1, userB)
                ORDER BY    numMutualFriends(user1, userB) DESC;
                
        OPEN cur;

    END@