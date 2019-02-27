
CREATE TABLE PageOwner
	(ownID INTEGER NOT NULL PRIMARY KEY,
	 description VARCHAR(200),
	 privacy VARCHAR(25) NOT NULL,
	 pageID INTEGER UNIQUE NOT NULL
	)

CREATE TABLE User
	(ownID INTEGER NOT NULL PRIMARY KEY,
	 username VARCHAR(20) UNIQUE NOT NULL,
	 birthday DATE,
	 email VARCHAR(100) NOT NULL UNIQUE,
	 password VARCHAR(100) NOT NULL,
	 FOREIGN KEY (ownID) REFERENCES PageOwner
	)

CREATE TABLE Group
	(ownID INTEGER NOT NULL PRIMARY KEY,
	 groupeName VARCHAR(50) NOT NULL,
	 creator INTEGER NOT NULL,
	 FOREIGN KEY (ownID) REFERENCES PageOwner,
	 FOREIGN KEY (creator) REFERENCES User (ownID)
	)

CREATE TABLE Event
	(ownID INTEGER NOT NULL PRIMARY KEY,
	 eventName VARCHAR(50) NOT NULL,
	 eventDate TIMESTAMP,
	 location VARCHAR(100),
	 planner INTEGER NOT NULL,
	 FOREIGN KEY (ownID) REFERENCES PageOwner,
         FOREIGN KEY (planner) REFERENCES User (ownID)
	)

CREATE TABLE Post
	(pID INTEGER NOT NULL PRIMARY KEY,
	 postDate TIMESTAMP NOT NULL,
	 message VARCHAR(500) NOT NULL,
	 poster INTEGER NOT NULL,
	 page INTEGER NOT NULL,
         originalPost INTEGER,
	 FOREIGN KEY (poster) REFERENCES User (ownID),
	 FOREIGN KEY (page) REFERENCES PageOwner(pageID),
         FOREIGN KEY (originialPost) REFERENCES Post (pID)
	)

CREATE TABLE Comment
	(cID INTEGER NOT NULL PRIMARY KEY,
	 postDate TIMESTAMP NOT NULL,
	 message VARCHAR(200) NOT NULL,
	 post INTEGER NOT NULL,
	 poster INTEGER NOT NULL,
	 originalComment INTEGER,
	 FOREIGN KEY (post) REFERENCES Post(pID),
	 FOREIGN KEY (poster) REFERENCES User(ownID),
         FOREIGN KEY (originalComment) REFERENCES Comment(cID)
	)

CREATE TABLE Tag
	(tName VARCHAR(20) NOT NULL PRIMARY KEY)

CREATE TABLE PrivateMessage
	(pmID INTEGER NOT NULL PRIMARY KEY,
	 message VARCHAR(200) NOT NULL,
	 sender INTEGER NOT NULL,
	 receiver INTEGER NOT NULL,
	 dateSent TIMESTAMP NOT NULL,
	 dateRead TIMESTAMP,
	--read BOOLEAN,
	 FOREIGN KEY (sender) REFERENCES User(ownID),
	 FOREIGN KEY (receiver) REFERENCES User(ownID),
	--CHECK ((read AND dateRead is NOT NULL) OR (NOT read AND dateRead is NULL))
	)

CREATE TABLE Friends
	(userA INTEGER NOT NULL,
	 userB INTEGER NOT NULL,
	 sinceWhen DATE NOT NULL,
	 PRIMARY KEY (userA, userB),
	 FOREIGN KEY (userA) REFERENCES User(ownID),
	 FOREIGN KEY (userB) REFERENCES User(ownID)
	)

CREATE TABLE ContainsTag
	(post INTEGER NOT NULL,
	 tag VARCHAR(20) NOT NULL,
	 PRIMARY KEY(post,tag),
	 FOREIGN KEY (post) REFERENCES Post(pID),
	 FOREIGN KEY (tag) REFERENCES Tag(tName)
	)

CREATE TABLE MemberOF
	(uid INTEGER NOT NULL,
	 gid INTEGER NOT NULL,
	 PRIMARY KEY (uid, gid),
	 FOREIGN KEY (uid) REFERENCES User(ownID),
	 FOREIGN KEY (gid) REFERENCES Group(ownID)
	)

CREATE TABLE Administers
        (uid INTEGER NOT NULL,
         gid INTEGER NOT NULL,
         PRIMARY KEY (uid, gid),
         FOREIGN KEY (uid) REFERENCES User(ownID),
         FOREIGN KEY (gid) REFERENCES Group(ownID, 
        )

CREATE TABLE GoingTo
        (uid INTEGER NOT NULL,
         eid INTEGER NOT NULL,
         PRIMARY KEY (uid, eid),
         FOREIGN KEY (uid) REFERENCES User,
         FOREIGN KEY (eid) REFERENCES Event,
        )
