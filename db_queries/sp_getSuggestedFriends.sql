CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    P1: BEGIN

        CREATE Table TempSuggested(
            suggestion INTEGER UNIQUE NOT NULL PRIMARY KEY,
            mutualFriends BIGINT NOT NULL DEFAULT 0,
            FOREIGN KEY (suggestion) REFERENCES User(ownID)
        );

        INSERT INTO TempSuggested(suggestion)
        SELECT USERB
            FROM FRIENDSOFFRIENDS
        WHERE USERA = user1;

        UPDATE TempSuggested
        SET mutualFriends = 
            (SELECT COUNT(*)
                FROM TABLE(getMutualFriends(user1, suggestion)));

        DECLARE cur CURSOR WITH RETURN TO CALLER
            FOR SELECT * 
                    FROM TempSuggested
                ORDER BY mutualFriends DESC;

        OPEN cur;

        DROP TABLE IF EXISTS TempSuggested;

    END P1@