OP VIEW PublicPageOwners;
DROP VIEW PublicUsers;
DROP VIEW PublicGroups;
DROP VIEW PublicEvents;
DROP VIEW BiDirectionalFriends;
DROP VIEW FriendsOfFriends;

-- PublicPageOwners, PublicUsers, PublicGroups, PublicEvents are simply subsets of their respective groups where the privacy setting is set to public

CREATE VIEW PublicPageOwners
as
SELECT * FROM PageOwner WHERE privacy = 'public';

CREATE VIEW PublicUsers
as
SELECT u.ownID, username, birthday, email, description, privacy, pageID FROM
        (USER u JOIN PublicPageOwners o ON u.ownID = o.ownID);

CREATE VIEW PublicGroups
as
SELECT g.ownID, groupeName, creator, description, privacy, pageID  FROM
        (Group g JOIN PublicPageOwners o ON g.ownID = o.ownID);

CREATE VIEW PublicEvents
as
SELECT e.ownID, eventName, eventDate, location, planner, description, privacy, pageID FROM
        (Event e JOIN PublicPageOwners o ON e.ownID = o.ownID);



-- BiDirectionFriends is an extension of the friends table. 
--In the friends table, either a friendship between A and B is stored as (A, B, startdate) or (B, A, startdate).
--BiDirectionFriends contain both (B, A, startdate) and (A, B, startdate)

CREATE VIEW BiDirectionalFriends
as
        SELECT * FROM Friends
        UNION
        SELECT userB, userA, sinceWhen FROM Friends;


-- If A is friends with B, and B is friends with C, then A and C are friends of friends
-- FriendsOfFriends holds this data, excluding when A = C, or A and C are already friends
CREATE VIEW FriendsOfFriends
as
        SELECT u1.userA, u2.userB
        FROM(BiDirectionalFriends u1 JOIN BiDirectionalFriends u2 ON u1.userB = u2.userA)
        EXCEPT
        SELECT userA, userB
        FROM BiDirectionalFriends
        EXCEPT
        SELECT ownID, ownID FROM User;


SELECT * FROM BiDirectionalFriends;
SELECT * FROM FriendsOfFriends;

SELECT ownID, groupeName, privacy FROM PublicGroups;
UPDATE Group
        SET groupeName = 'Computer Science'
        WHERE groupeName = 'CompSci';
UPDATE PageOwner
        SET privacy = 'private' WHERE ownID = 100196380;

SELECT ownID, groupeName, privacy FROM PublicGroups;

SELECT * FROM FriendsOfFriends fetch first 7 rows only;
DELETE FROM friends where userA = 0 AND userB = 2;
INSERT INTO Friends VALUES (1,2,(Values current TIMESTAMP));
SELECT * FROM FriendsOfFriends fetch first 7 rows only;

-- As shown by the Logfile changing the values of the base tables changes the values of the views.
-- This is because the first view is simply a conditional subset, so the querey
