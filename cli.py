import ibm_db

db_connection = ibm_db.pconnect("jdbc:db2://comp421.cs.mcgill.ca:50000/cs421","cs421g43","SonicTH1991")

test = ibm_db.exec_immediate(db_connection, "connect to cs421; select * from User;")

print ("TEST: ", ibm_db.num_rows(test))

while(1):
    print ('hello')