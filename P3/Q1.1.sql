CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN ATOMIC

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      userB AS suggested, 
                            numMutualFriends(user1, userB) AS mutual
                FROM        FriendsOfFriends
                WHERE       userA = user1
                AND NOT     areFriends(user1, userB) = 1
                ORDER BY    mutual DESC;
                
        OPEN cur;

    END@