CREATE OR REPLACE PROCEDURE getSuggestedFriends(IN user1 INTEGER)
    LANGUAGE SQL

    BEGIN

        CREATE Table TempSuggested(
            suggestion INTEGER UNIQUE NOT NULL PRIMARY KEY,
            mutualFriends BIGINT NOT NULL DEFAULT 0,
            FOREIGN KEY (suggestion) REFERENCES User(ownID)
        );

        INSERT INTO TempSuggested(suggestion)
        SELECT USERB
            FROM FRIENDSOFFRIENDS
        WHERE USERA = user1;

        INSERT INTO TempSuggested(mutualFriends)
        SELECT COUNT(total)
            FROM (CALL getMutualFriends(user1, ts.suggestion)) as total
            JOIN TempSuggested as ts
        WHERE suggestion = ts.suggestion;

        SELECT * 
            FROM TempSuggested
        ORDER BY mutualFriends DESC;

        DROP TABLE IF EXISTS TempSuggested;

    END@