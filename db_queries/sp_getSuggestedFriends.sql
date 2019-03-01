CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN 

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT      userB AS suggested
                FROM        FriendsOfFriends
                WHERE       userA = user1
                ORDER BY    numMutualFriends(user1, userB) DESC;
                
        OPEN cur;

    END@