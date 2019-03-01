# Table/View                      Schema          Type  Creation time
# ------------------------------- --------------- ----- --------------------------
# ADMINISTERS                     CS421G43        T     2019-02-25-16.59.47.779186
# COMMENT                         CS421G43        T     2019-02-25-16.59.46.733057
# CONTAINSTAG                     CS421G43        T     2019-02-25-16.59.47.470076
# EVENT                           CS421G43        T     2019-02-25-16.59.46.390286
# FRIENDS                         CS421G43        T     2019-02-25-16.59.47.298675
# GOINGTO                         CS421G43        T     2019-02-25-16.59.47.950084
# GROUP                           CS421G43        T     2019-02-25-16.59.46.219100
# LIKE                            CS421G43        T     2019-02-25-16.59.48.119889
# MEMBEROF                        CS421G43        T     2019-02-25-16.59.47.610708
# PAGEOWNER                       CS421G43        T     2019-02-25-16.59.45.756370
# POST                            CS421G43        T     2019-02-25-16.59.46.562963
# PRIVATEMESSAGE                  CS421G43        T     2019-02-25-16.59.47.128806
# TAG                             CS421G43        T     2019-02-25-16.59.46.958387
# USER                            CS421G43        T     2019-02-25-16.59.46.012782

import random;
import string;
import itertools;

random.seed(0)

def randomTimeStamp():
    year = str(random.randint(2000,2019))
    month = "{:02d}".format(random.randint(1,12))
    day = "{:02d}".format(random.randint(1,28))
    hour = "{:02d}".format(random.randint(0,23))
    minute = "{:02d}".format(random.randint(0,59))
    sec = "00"#"{:02d}".format(random.randint(0,59))
    return "TimeStamp('" + year + "-" + month + "-" + day + "-" + hour + "." + minute + "." + sec +"')"


privacySetting = ["private", "public", "friends"]

PageOwnerIds = []
UserIds = []
EventIds = []
GroupIds = []
PageIds = []

PostIDs = []
TagList = []
CommentIds = []

FriendsList = []

CommentPost = {}

HashTagList = ["HashTag1", "HashTag2", "HashTag3", "HashTag4", "HashTag5"]

for l in HashTagList:
    print("INSERT INTO Tag VALUES('"+ l +"');")

print()

Locations = []
for i in range(3):
    Locations.append(''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(80)))

while len(PageOwnerIds) < 10:
    oID = random.randint(0, 2 ** 30)
    if oID not in PageOwnerIds:
        PageOwnerIds.append(oID)
        UserIds.append(oID)
        desc = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(150))
        privacy = random.choice(privacySetting)
        while True:
            pageID = random.randint(0, 2 ** 30)
            if pageID not in PageIds:
                break
        PageIds.append(pageID)
        username = ''.join(random.choice(string.ascii_uppercase) for _ in range(15))
        year = random.randint(1950, 2010)
        email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(80))
        password = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(80))

        print("INSERT INTO PageOwner VALUES(" + str(oID) + ", '" + desc + "', '" + privacy + "', " + str(pageID) + ");")
        print("INSERT INTO User VALUES(" + str(oID) + ", '" + username + "', DATE('" +
              str(year) + "-01-01'), '" + email + "', '" + password + "');\n")

while len(PageOwnerIds) < 20:
    oID = random.randint(0, 2 ** 30)
    if oID not in PageOwnerIds:
        PageOwnerIds.append(oID)
        GroupIds.append(oID)
        desc = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(150))
        privacy = random.choice(privacySetting)
        while True:
            pageID = random.randint(0, 2 ** 30)
            if pageID not in PageIds:
                break
        PageIds.append(pageID)

        groupname = ''.join(random.choice(string.ascii_uppercase) for _ in range(45))
        creator = random.choice(UserIds)

        print("INSERT INTO PageOwner VALUES(" + str(oID) + ", '" + desc + "', '" + privacy + "', " + str(pageID) + ");")
        print("INSERT INTO GROUP VALUES(" + str(oID) + ", '" + groupname + "', " + str(creator) + ");\n")

while len(PageOwnerIds) < 30:
    oID = random.randint(0, 2 ** 30)
    if oID not in PageOwnerIds:
        PageOwnerIds.append(oID)
        EventIds.append(oID)
        desc = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(150))
        privacy = random.choice(privacySetting)
        while True:
            pageID = random.randint(0, 2 ** 30)
            if pageID not in PageIds:
                break
        PageIds.append(pageID)
        eventName = ''.join(random.choice(string.ascii_uppercase) for _ in range(45))
        planner = random.choice(UserIds)
        month = random.randrange(1, 12, 3)
        location = random.choice(Locations)

        print("INSERT INTO PageOwner VALUES(" + str(oID) + ", '" +
              desc + "', '" + privacy + "', " + str(pageID) + ");")
        print("INSERT INTO Event VALUES(" + str(oID) + ", '" +
              eventName + "', DATE('2019-" + str(month) + "-01'), '" +
              location + "', " + str(creator) + ");\n")

friends1 = itertools.combinations(UserIds,2)
friends2 = [item for item in friends1];
for (x,y) in random.sample(friends2,25):
    FriendsList.append((x,y))
    year = random.randrange(2000, 2018)
    month = random.randrange(1,12)
    day = random.randrange(1,28)
    print("INSERT INTO Friends VALUES(" + str(x) + ", " + str(y) + ", DATE('" +
          str(year) + "-" + str(month) + "-" + str(day) + "'));")

print()

for u in UserIds:
    groups = random.sample(GroupIds,3)
    events = random.sample(EventIds,3)

    print("INSERT INTO ADMINISTERS VALUES({},{});".format(u,groups[0]))
    for i in range(3):
        print("INSERT INTO MEMBEROF VALUES({},{});".format(u,groups[i]))
        print("INSERT INTO GOINGTO VALUES({},{});".format(u,events[i]))


print()

while len(PostIDs) < 50:
    pID = random.randint(0, 2 ** 30)
    if pID not in PostIDs:
        PostIDs.append(pID)
        postDate = randomTimeStamp()
        message = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(100))
        numHT = random.randint(0,3)
        HTgs = random.sample(HashTagList,numHT)
        for t in HTgs:
            message = message + " " + "#" + t
        poster = random.choice(UserIds)
        page = random.choice(PageIds)
        if random.random() < 0.5:
            original = random.choice(PostIDs)
            if original == pID:
                original = -1
        else:
            original = -1
        if original == -1:
            print("INSERT INTO Post VALUES(" + str(pID) + ", " + postDate + ", '" +
                   message + "', " + str(poster) + ", " + str(page) + ", NULL);")
        else:
            print("INSERT INTO Post VALUES(" + str(pID) + ", " + postDate + ", '" +
                   message + "', " + str(poster) + ", " + str(page) + ", " + str(original) + ");")
        for t in HTgs:
            print("INSERT INTO ContainsTag VALUES (" + str(pID) + ", '" + t + "');")

print()

while(len(CommentIds) < 100):
    cID = random.randint(0, 2 ** 30)
    if cID not in CommentIds:
        postDate = randomTimeStamp()
        message = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(100))
        poster = random.choice(UserIds)
        post = random.choice(PostIDs)
        if len(CommentIds) > 0 and random.random() < 0.5:
            original = random.choice(CommentIds)
        else:
            original = -1
        CommentIds.append(cID)
        if original == -1:
            CommentPost[cID] = post
            print("INSERT INTO Comment VALUES(" + str(cID) + ", " + postDate + ", '" +
                   message + "', " + str(post) + ", " + str(poster) + ", NULL);")
        else:
            post = CommentPost[original]
            CommentPost[cID] = post
            # query = "(SELECT post FROM Comment o WHERE o.cID = originalcomment)"
            print("INSERT INTO Comment VALUES(" + str(cID) + ", " + postDate + ", '" +
                   message + "', " + str(post) + ", " + str(poster) + ", " + str(original) + ");")

print()

for (x,y) in random.sample(FriendsList,20):
    length = random.randint(0,30)
    for i in range(length):
        person = random.randint(0,1)
        pID = str(random.randint(0, 2**30))
        message = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(50))
        if i == 0:
            sender = str(x)
            receiver = str(y)
        else:
            sender = str(y)
            receiver = str(x)
        dateSent = randomTimeStamp()
        dateRec = dateSent
        print("INSERT INTO PrivateMessage VALUES({},'{}',{},{},{},{});".format(
            pID, message, sender, receiver, dateSent, dateRec
        ))

print()

for user in UserIds:
    for post in random.sample(PostIDs,3):
        print("INSERT INTO Like VALUES({},{});".format(
            str(user), str(post)
        ))

print()
