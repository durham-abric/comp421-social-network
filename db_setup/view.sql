DROP VIEW PublicPageOwners;
DROP VIEW PublicUsers;
DROP VIEW PublicGroups;
DROP VIEW PublicEvents;
DROP VIEW BiDirectionalFriends;
DROP VIEW FriendsOfFriends;

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

CREATE VIEW BiDirectionalFriends
as
	SELECT * FROM Friends
	UNION
	SELECT userB, userA, sinceWhen FROM Friends;

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

--SELECT u1.username, u2.username FROM
--User u1, friendsOfFriends f, User u2 WHERE u1.ownID = f.userA AND u2.ownID = f.userB

SELECT ownID, groupeName, privacy FROM PublicGroups;
UPDATE Group
	SET groupeName = 'Computer Science'
	WHERE groupeName = 'CompSci';
UPDATE PageOwner
	SET privacy = 'private' WHERE ownID = 100196380;
	
SELECT ownID, groupeName, privacy FROM PublicGroups;

SELECT * FROM FriendsOfFriends;
DELETE FROM friends where userA = 0 AND userB = 2;
INSERT INTO Friends VALUES (1,2,(Values current TIMESTAMP));
SELECT * FROM FriendsOfFriends;
