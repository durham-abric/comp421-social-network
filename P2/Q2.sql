DROP TABLE PageOwner;
DROP TABLE User;
DROP TABLE Group;
DROP TABLE Event;
DROP TABLE Post;
DROP TABLE Comment;
DROP TABLE Tag;
DROP TABLE Friends;
DROP TABLE PrivateMessage;
DROP TABLE ContainsTag;
DROP TABLE MemberOF;
DROP TABLE Administers;
DROP TABLE GoingTo;
DROP TABLE Like;

-- PageOwn must have an ID, a page, and a privacy setting
-- The privacy setting must either be public, private, friends
CREATE TABLE PageOwner
        (ownID INTEGER NOT NULL PRIMARY KEY,
         description VARCHAR(200),
         privacy VARCHAR(25) NOT NULL DEFAULT 'public',
         pageID INTEGER UNIQUE NOT NULL,
         CHECK (privacy IN ('public', 'private', 'friends'))
        );

-- Users must have an ID, username, email, and password
CREATE TABLE User
        (ownID INTEGER NOT NULL PRIMARY KEY,
         username VARCHAR(20) UNIQUE NOT NULL,
         birthday DATE,
         email VARCHAR(100) UNIQUE NOT NULL,
         password VARCHAR(100) NOT NULL,
         FOREIGN KEY (ownID) REFERENCES PageOwner
        );

-- Groups must have an ID, name, and a creator
CREATE TABLE Group
        (ownID INTEGER NOT NULL PRIMARY KEY,
         groupeName VARCHAR(50) NOT NULL,
         creator INTEGER NOT NULL,
         FOREIGN KEY (ownID) REFERENCES PageOwner,
         FOREIGN KEY (creator) REFERENCES User (ownID)
        );

-- Events must have an ID, name, and a plannar
CREATE TABLE Event
        (ownID INTEGER NOT NULL PRIMARY KEY,
         eventName VARCHAR(50) NOT NULL,
         eventDate TIMESTAMP,
         location VARCHAR(100),
         planner INTEGER NOT NULL,
         FOREIGN KEY (ownID) REFERENCES PageOwner,
         FOREIGN KEY (planner) REFERENCES User (ownID)
        );

-- Post must have an ID, must have when it was posted, who it was posted by, and must have a non empty message
-- A share can't be sharing itself
CREATE TABLE Post
        (pID INTEGER NOT NULL PRIMARY KEY,
         postDate TIMESTAMP NOT NULL,
         message VARCHAR(500) NOT NULL,
         poster INTEGER NOT NULL,
         page INTEGER NOT NULL,
         originalPost INTEGER,
         FOREIGN KEY (poster) REFERENCES User (ownID),
         FOREIGN KEY (page) REFERENCES PageOwner(pageID),
         FOREIGN KEY (originalPost) REFERENCES Post (pID),
         CHECK (NOT pID = originalPost)
        );

-- Comment must have an ID, must have when it was posted, who it was posted by, a post that the comment is commenting on and must have a non empty message
-- A reply can't be a reply to itself
-- A reply must be commented on the same post as the comment it's replying to (Can't apply using check constraint)
CREATE TABLE Comment
        (cID INTEGER NOT NULL PRIMARY KEY,
         postDate TIMESTAMP NOT NULL,
         message VARCHAR(200) NOT NULL,
         post INTEGER NOT NULL,
         poster INTEGER NOT NULL,
         originalComment INTEGER,
         FOREIGN KEY (post) REFERENCES Post(pID),
         FOREIGN KEY (poster) REFERENCES User(ownID),
         FOREIGN KEY (originalComment) REFERENCES Comment(cID),
         CHECK (NOT originalComment = cID)
        );

CREATE TABLE Tag
        (tName VARCHAR(20) NOT NULL PRIMARY KEY);

-- Friends must be between two DIFFERENT users and must have a start date for their friendship
CREATE TABLE Friends
        (userA INTEGER NOT NULL,
         userB INTEGER NOT NULL,
         sinceWhen DATE NOT NULL,
         PRIMARY KEY (userA, userB),
         FOREIGN KEY (userA) REFERENCES User(ownID),
         FOREIGN KEY (userB) REFERENCES User(ownID),
         CHECK (NOT userA = userB)
        );

-- PrivateMessage must have a sender and a reciever, and an ID
-- It must have a send timestamp
-- If the message was seen, then it must have a timestamp when it was read, NULL otherwise
-- Depending on a users privacy setting (Can't apply using check constraint):
	-- A private user can only receive new messages from friends
	-- A public user can receive new messages from anyone
	-- A "friend" user can receive new messages from friends of friends
-- A New message can't be sent unless all previous message made by the other person have be read by you. (Can't apply using check constraint)
CREATE TABLE PrivateMessage
        (pmID INTEGER NOT NULL PRIMARY KEY,
         message VARCHAR(200) NOT NULL,
         sender INTEGER NOT NULL,
         receiver INTEGER NOT NULL,
         dateSent TIMESTAMP NOT NULL,
         dateRead TIMESTAMP,
         FOREIGN KEY (sender) REFERENCES User(ownID),
         FOREIGN KEY (receiver) REFERENCES User(ownID)
        );

-- Post's message must contain the substring "#($tagname)" (Can't apply using check constraint)
CREATE TABLE ContainsTag
        (post INTEGER NOT NULL,
         tag VARCHAR(20) NOT NULL,
         PRIMARY KEY (post,tag),
         FOREIGN KEY (post) REFERENCES Post(pID),
         FOREIGN KEY (tag) REFERENCES Tag(tName)
        );

CREATE TABLE MemberOF
        (uid INTEGER NOT NULL,
         gid INTEGER NOT NULL,
         PRIMARY KEY (uid, gid),
         FOREIGN KEY (uid) REFERENCES User(ownID),
         FOREIGN KEY (gid) REFERENCES Group(ownID)
        );

CREATE TABLE Administers
        (uid INTEGER NOT NULL,
         gid INTEGER NOT NULL,
         PRIMARY KEY (uid, gid),
         FOREIGN KEY (uid) REFERENCES User(ownID),
         FOREIGN KEY (gid) REFERENCES Group(ownID)
        );

CREATE TABLE GoingTo
        (uid INTEGER NOT NULL,
         eid INTEGER NOT NULL,
         PRIMARY KEY (uid, eid),
         FOREIGN KEY (uid) REFERENCES User(ownID),
         FOREIGN KEY (eid) REFERENCES Event(ownID)
        );

CREATE TABLE Like
	(uid INTEGER NOT NULL,
	 pid INTEGER NOT NULL,
	 PRIMARY KEY (uid, pid),
         FOREIGN KEY (uid) REFERENCES User(ownID),
         FOREIGN KEY (pid) REFERENCES Post
        );


