# pip install mysqlclient
import MySQLdb

conn = MySQLdb.connect(
    host="rm-0iw9g2v7a7w57731iao.mysql.japan.rds.aliyuncs.com",
    user="dbadmin",
    passwd="6wN7(*G5Gx37",
    db="op_system")

cur = conn.cursor()

# conn.begin()
# cur.execute("truncate table warm_epiration")
# conn.commit()

# conn.begin()
# cur.execute("select * from salelocs")

# i = 0
# insertSql = "insert into warm_epiration (saleloc_id, over) values "
# for row in cur.fetchall():
#     i = i + 1

#     if i > 400:
#         break
#     print(str(i))
#     if i == 1:
#         insertSql = insertSql + "("+str(row[0])+",1)"
#     else:
#         insertSql = insertSql + ",("+str(row[0])+",1)"

# cur.execute(insertSql)
# conn.commit()

conn.begin()
cur.execute("truncate table demandforecast")
conn.commit()

conn.begin()
cur.execute("select * from vminventories where good_id is not null")

i = 0
insertSql = "insert into demandforecast (saleloc_id,goods_id,column_no,dailysale_num,forecast_num) values "
for row in cur.fetchall():
    i = i + 1

    if i > 12000:
        break
    print(str(i))
    if i == 1:
        insertSql = insertSql + "(" + str(row[1]) + "," + str(
            row[2]) + "," + str(row[3]) + ",10000,10)"
    else:
        insertSql = insertSql + ",(" + str(row[1]) + "," + str(
            row[2]) + "," + str(row[3]) + ",10000,10)"
print(insertSql)
cur.execute(insertSql)
conn.commit()

# conn.begin()
# cur.execute("select * from vms")

# i = 0
# insertSql = "insert into vmtroublehistoryinfos (pos_code, is_solved, vm_id,vmtroubleinfo_id) values "
# for row in cur.fetchall():
#     i = i + 1

#     if i > 400:
#         break
#     print(str(i))
#     if i == 1:
#         insertSql = insertSql + "(9090909,0,"+str(row[0])+",1)"
#     else:
#         insertSql = insertSql + ",(9090909,0,"+str(row[0])+",1)"

# cur.execute(insertSql)
# conn.commit()

conn.close()