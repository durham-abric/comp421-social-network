CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL
    BEGIN
        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT DISTINCT(USERB) 
                    FROM FRIENDSOFFRIENDS
                WHERE USERA = user1
                ORDER BY COUNT(CALL getMutualFriends(user1, USERB) DESC;
        OPEN cur;
    END@