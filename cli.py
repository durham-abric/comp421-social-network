import ibm_db as db2
import datetime
import random

def connect_to_db():
    connected = False
    db_cfg = "DRIVER=DB2;DATABASE=cs421;HOSTNAME=comp421.cs.mcgill.ca;PORT=50000;PROTOCOL=TCPIP;UID=cs421g43;PWD=SonicTH1991;ConnectTimeout=100;"
    db_con = None

    while(connected == False):
        db_con = db2.connect(db_cfg,"","")
        if (db_con is None):
            print("Error: Could not connect to database...")
            reconnect = input("Try to connect again? (Y/N): ").upper()
            if(reconnect == 'N'):
                print("Sorry for the trouble!")
                print("Exiting G43-SocialNet")
                exit(0)
            elif(reconnect == 'Y'):
                print("Attempting to connect again...")
            else:
                print("Invalid input: Attempting to connect again... [default]")
        else:
            connected = True
    return db_con

def identify_user():
    print("To continue:")
    print("\tReturning Users\t-\tLogin")
    print("\tNew Users\t-\tSignup")
    user_setup = None
    identified = False
    while(identified != True):
        user_setup = input("\nWould you like to signup or login?\t").lower()
        identified = (user_setup == 'signup' or user_setup == 'login')
        while(identified != True):
            print("Sorry - we didn't understand that...")
            ask_again = input('Do you want to try again? (Y/N)').upper()
            if(ask_again == 'N'):
                print("Come back soon!")
                print("Exiting G43-SocialNet")
                exit(0);
            elif(ask_again == 'Y'):
                break
            else:
                continue
    return user_setup

def login_process(db_connection):
    logged_in = False
    session_data = None
    while(logged_in == False):
        print("Login (case sensitive):")
        user = input("\tEnter Username\t-\t")
        pwd = input("\tEnter Password\t-\t ")

        login_query = "SELECT * FROM User WHERE username = \'{0}\' AND password = \'{1}\'".format(user, pwd)
        login_stmt = db2.exec_immediate(db_connection, login_query)
        login_res = db2.fetch_assoc(login_stmt)

        if(login_res != False):
            uID = login_res["OWNID"]
            username = login_res["USERNAME"]
            email = login_res["EMAIL"]
            print(login_res['BIRTHDAY'])
            logged_in = True;
            session_data = (uID, username, email)
            break
        else:
            print("Account not found!")
            retry = input("Would you like to try logging in again? (Y/N): ")
            if(retry == 'N'):
                print("Come back soon!")
                print("Exiting G43-SocialNet")
                exit(0);
            elif(retry == 'Y'):
                continue
            else:
                print("Invalid input: Login unsuccesful")
                break
    return session_data

def signup_user(db_connection):

    new_user = None

    print("To signup, you'll have to enter some personal information")
    name = input("\tWhat's your name?\t")
    email = input("\tWhat's your email address?\t")
    year = input("\tWhat year were you born in?\t")
    month = input("\tWhat month were you born in?\t(1-12)")
    day = input("\tWhat day were you born on?\t")
    password = input("\tWhat would you like your password to be?\t")

    description = input("\tHow would you describe yourself?\t")
    privacy = input("\tWhich privacy level would you like [private, public, friends]?\t")

    #bday = datetime.datetime(int(year), int(month), int(day))

    userID = random.randint(0, 2 ** 30)
    pageID = random.randint(0, 2 ** 30)

    insert_owner = "INSERT INTO PageOwner VALUES ({0}, \'{1}\', \'{2}\', {3})".format(userID, description, privacy, pageID)
    insert_user = "INSERT INTO User VALUES ({0}, \'{1}\', \'{2}-{3}-{4}\', \'{5}\',\'{6}\')".format(userID, name, year, month, day, email, password)
    owner_stmt = db2.exec_immediate(db_connection, insert_owner)
    if(owner_stmt != False):
        signup_stmt = db2.exec_immediate(db_connection, insert_user)
        if(signup_stmt != False):
            print("Account created...\nWelcome to G43-SocialNet")
            new_user = (userID, name, email)
        else:
            print("Account (User) could not be created... Try again!")
            rollback = db2.exec_immediate(db_connection, "DELETE FROM PageOwner WHERE ownID = {0} AND pageID = {1}".format(userID, pageID))
            if(rollback == False):
                print("Error: Contact database administrators to resolve unnecessary PageOwner entry")
                print("Aborting G43-SocialNet")
                exit(1)
    else:
        print("Account (Page) could not be created... Try again!")
    return new_user

def print_menu():
    print("\nWhat can you do?\n\n")
    print("Action\t\t\tCommand\t\t\tParameters")
    print("______\t\t\t_______\t\t\t__________\n")
    print("See a User's Profile\tView\t\t<username>")
    print("Send a Friend Request\tFriend\t\t<username>")
    print("Send a Private Message\tMessage\t\t<recipient_username> -m <message>")
    print("See News Feed\t\tNewsFeed")
    print("Get Help\t\tHelp")
    print("Logout of Account\tLogout")
    print("Quit SocialNet\tExit")

#### MAIN PROGRAM OPERATION ####
running = True
available_commands = {"view", "friend", "message", "newsfeed", "post", "help", "logout", "exit"}
print("Welcome to G43-SocialNet!\n_____________________\n\n")

while(running == True):
    connection = connect_to_db()
    today = datetime.datetime.now()
    if(connection is None):
        print("Error: DB cannot be accessed")
        print("Aborting G43-SocialNet")
        exit(1);

    user = None;
    
    while(user is None):
        startup_type = identify_user()
        if(startup_type == 'login'):
            user = login_process(connection)
        elif(startup_type == 'signup'):
            user = signup_user(connection)
    
        if(user is None):
            print("That didn't go as planned... let's try again!\n")
        else:
            print("Login successful!\n")
    
    while(user is not None):
        print("Welcome to SocialNet, {0}!".format(user[1]))
        print_menu()
        print(user)
        print("\nSocialNet Command Line Interface:\n")
        while(True):
            command = input("\t->  ")
            args = command.split()
            if(args[0].lower() in available_commands):
                if(args[0].lower() == "view"):
                    uid_query = "SELECT * FROM User WHERE username = \'{0}\'".format(' '.join(args[1:]))
                    uid_stmt = db2.exec_immediate(connection, uid_query)
                    uid_res = db2.fetch_assoc(uid_stmt)
                    if(uid_res != False):
                        friend_id = uid_res['OWNID']
                    else:
                        print("That user doesn't have an account on SocialNet...")
                        break
                    
                    owner_query = "SELECT privacy, description FROM PageOwner WHERE ownID = {0}".format(friend_id)
                    owner_stmt = db2.exec_immediate(connection, owner_query)
                    owner_res = db2.fetch_assoc(owner_stmt)
                    if(owner_res != False):
                        owner_prv = owner_res['PRIVACY']
                    else:
                        print("That user doesn't have an page on SocialNet...")
                        break

                    friend_query = "VALUES(areFriends({0},{1}))".format(user[0],friend_id)
                    friend_stmt = db2.exec_immediate(connection, friend_query)
                    friend_res = db2.fetch_tuple(friend_stmt)
                    if(owner_prv == 'public' or (owner_prv == 'friends' and friend_res[0])):
                        print("Username: {0}".format(uid_res['USERNAME']))
                        if(friend_res[0] == 1):
                            print("You are friends with {0}!\n".format(uid_res['USERNAME']))
                        else:
                            print("You are not friends with {0}!\n".format(uid_res['USERNAME']))
                        print("E-Mail: {0}".format(uid_res['EMAIL']))
                        print("Birthday: {0}".format(uid_res['BIRTHDAY']))
                        print("Description: {0}".format(owner_res['DESCRIPTION']))
                    else:
                        print("You can't view that user's page (privacy settings).")

                elif(args[0].lower() == "friend"):
                    uid_query = "SELECT * FROM User WHERE username = \'{0}\'".format(' '.join(args[1:]))
                    uid_stmt = db2.exec_immediate(connection, uid_query)
                    uid_res = db2.fetch_assoc(uid_stmt)
                    if(uid_res != False):
                        friend_id = uid_res['OWNID']
                    else:
                        print("That user doesn't have an account on SocialNet...")
                        break
                    
                    friend_query = "VALUES(areFriends({0},{1}))".format(user[0], friend_id)
                    friend_stmt = db2.exec_immediate(connection, friend_query)
                    friend_res = db2.fetch_tuple(friend_stmt)
                    if(friend_res[0] == 1):
                        print("You are already friends with {0}".format(args[1:]))
                    else:
                        add_friend_query = "INSERT INTO Friends VALUES({0},{1},\'{2}\')".format(user[0],friend_id,today.strftime('%Y-%m-%d'))
                        add_friend_stmt = db2.exec_immediate(connection, add_friend_query)
                        print("You are now friends with {0}".format(args[1:]))
            
                elif(args[0].lower() == "message"):

                    msg_start = -1
                    for i in range(1,len(args)):
                        if (args[i] == '-m'):
                            msg_start = i
                            break
                    
                    if(msg_start == -1):
                        print("Invalid message format... Message User -m Message Goes Here")
                        break

                    uid_query = "SELECT * FROM User WHERE username = \'{0}\'".format(' '.join(args[1:msg_start]))
                    uid_stmt = db2.exec_immediate(connection, uid_query)
                    uid_res = db2.fetch_assoc(uid_stmt)
                    if(uid_res != False):
                        user_id = uid_res['OWNID']
                    else:
                        print("That user doesn't have an account on SocialNet...")
                        break

                    msgID = random.randint(0, 2 ** 30)
                    msg_query = "INSERT INTO PrivateMessage(pmID,message,sender,receiver,dateSent) VALUES({0},\'{1}\',{2},{3},\'{4}-12.00.00.000000\')".format(msgID,' '.join(args[msg_start:]),user[0],user_id,today.strftime("'%Y-%m-%d"))
                    msg_stmt = db2.exec_immediate(connection, msg_query)
                    print("Message sent!")
                elif(args[0].lower() == "newsfeed"):
                    print("newsfeed...")
                elif(args[0].lower() == "help"):
                    print_menu()
                elif(args[0].lower() == "logout"):
                    user = None
                    print("Logout succesful!")
                    break
                elif(args[0].lower() == "exit"):
                    print("Come back soon!")
                    print("Exiting G43-SocialNet")
                    exit(0)
                else:
                    print("Error: Invalid Command")
                    print("Command format unknown... Type \'Help\' to see available commands!")
            else:
                print("Command format unknown... Type \'Help\' to see available commands!")