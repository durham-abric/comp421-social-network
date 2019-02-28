--CREATE OR REPLACE PROCEDURE getMutualFriends(
--    IN user1 INTEGER,
--    IN user2 INTEGER)
--    LANGUAGE SQL
--    DYNAMIC RESULT SETS 1

--    C1: BEGIN
  
--        DECLARE c CURSOR WITH RETURN TO CLIENT
--            FOR


                SELECT DISTINCT(USERB) FROM BIDIRECTIONALFRIENDS AS bdf1
                    WHERE EXISTS(SELECT * FROM BIDIRECTIONALFRIENDS as bdf2 
                                WHERE bdf1.USERA = 1 
                                AND bdf2.USERB = 2 
                                AND bdf1.USERB = bdf2.USERB);
    
--        OPEN c;

--    END C1;

