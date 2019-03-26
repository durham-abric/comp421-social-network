import ibm_db as db2
import datetime
import random

def connect_to_db():
    connected = False
    db_cfg = "DRIVER=DB2;DATABASE=cs421;HOSTNAME=comp421.cs.mcgill.ca;PORT=50000;PROTOCOL=TCPIP;UID=cs421g43;PWD=SonicTH1991;ConnectTimeout=100;"
    
    while(connected == False):
        db_con = db2.connect(db_cfg,"","")
        if (db_con is None):
            print("Error: Could not connect to database...")
            reconnect = input("Try to connect again? (Y/N): ")
            if(reconnect.upper() == 'N'):
                print("Sorry for the trouble!")
                print("Exiting G43-SocialNet")
                exit(0)
            elif(reconnect.upper() == 'Y'):
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

    bday = datetime.date(year, month, day)

    userID = random.randint(0, 2 ** 30)
    pageID = random.randint(0, 2 ** 30)

    insert_owner = "INSERT INTO PageOwner VALUES (\'{0}\', \'{1}\', \'{2}\', \'{3}\')".format(userID, description, privacy, pageID)
    insert_user = "INSERT INTO User VALUES (\'{0}\', \'{1}\', \'{2}\', \'{3}\',\'{4}\')".format(userID, name, bday.isoformat, email, password)
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

#### MAIN PROGRAM OPERATION ####
running = True
print("Welcome to G43-SocialNet!\n_____________________")

while(running == True):
    connection = connect_to_db()
    if(connection is None):
        print("Error: DB cannot be accessed")
        print("Aborting G43-SocialNet")
        exit(1);

    start_type = identify_user()
    user = None;

    if(start_type == 'login'):
        user = login_process(connection)
    elif(start_type == 'signup'):
        user = signup_user(connection)
    
    #while(user is not None):
        #USER ACTIONS HERE
        #USER ACTIONS HERE


