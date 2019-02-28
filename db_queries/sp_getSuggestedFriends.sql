CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT USERB, COUNT(TABLE(getMutualFriends(user1, USERB))) AS numMutual
                    FROM FRIENDSOFFRIENDS as fof
                    JOIN TABLE(getMutualFriends(user1, USERB)) as mut
                        ON USERB = mut.mutualFriend
                WHERE USERA = user1
                ORDER BY numMutual DESC;
        
        OPEN cur;

    END@