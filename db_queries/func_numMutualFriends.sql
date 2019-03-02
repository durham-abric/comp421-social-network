CREATE OR REPLACE FUNCTION numMutualFriends(user1 INTEGER, 
                                            user2 INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    NO EXTERNAL ACTION

    BEGIN
        RETURN  SELECT  COUNT(*)
                FROM    TABLE(getMutualFriends(user1, user2));
    END@