CREATE OR REPLACE PROCEDURE getMutualFriends( IN user1 INTEGER, 
                                              IN user2 INTEGER)
    LANGUAGE SQL

    BEGIN

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT  DISTINCT(userB) 
                FROM    BidirectionalFriends AS bdf1
                WHERE   EXISTS( SELECT  * 
                                FROM    BidirectionalFriends as bdf2 
                                WHERE   bdf1.userA = user1 
                                        AND bdf2.userA = user2 
                                        AND bdf1.userB = bdf2.userB);

        OPEN cur;

    END@