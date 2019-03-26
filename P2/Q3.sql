INSERT INTO PAGEOWNER Values(0,'USER TEST 1', 'public', 0);
INSERT INTO User Values(0, 'Alex Oxorn', (Values current date), 'alex.oxorn@gmail.com', 'ALEXANDER');

INSERT INTO PAGEOWNER Values(1,'USER TEST 2', 'friends', 1);
INSERT INTO User Values(1, 'Olivia Strahan', (Values current date), 'rheala113@gmail.com', 'OLIVIA');

INSERT INTO PAGEOWNER Values(2,'USER TEST 3', 'private', 2);
INSERT INTO User Values(2, 'Nathan Palmer', (Values current date), 'ntp@gmail.com', 'ALEXANDER');

INSERT INTO PAGEOWNER Values(3,'USER TEST 4', 'private', 3);
INSERT INTO User Values(3, 'Cool Guy', (Values current date), 'cgE@gmail.com', 'EXTRA');

INSERT INTO PAGEOWNER Values(4,'GROUP TEST 1', 'public', 4);
INSERT INTO Group Values(4, 'CompSci', 0);

INSERT INTO PAGEOWNER Values(5,'GROUP TEST 2', 'friends', 5);
INSERT INTO Group Values(5, 'CBC', 0);

INSERT INTO MemberOF Values(0,4);
INSERT INTO MemberOF Values(1,4);
INSERT INTO MemberOF Values(3,4);

SELECT * FROM PageOwner;
SELECT * FROM User;
SELECT * FROM Group;
SELECT * FROM MemberOf;
