CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT USERB, COUNT(mut) AS numMutual
                    FROM FRIENDSOFFRIENDS as fof
                    LEFT JOIN TABLE(getMutualFriends(user1, USERB)) as mut
                        ON fof.USERB IN mut.mutualFriend
                WHERE fof.USERA = user1
                ORDER BY numMutual DESC;
        
        OPEN cur;

    END@