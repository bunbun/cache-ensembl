#!/usr/bin/env python
import MySQLdb, re, os, struct, time
import MySQLdb.cursors
from collections import defaultdict

def connect_ensembl_mysql (**connection_settings):
    """
    Get connection to Ensembl database
    """
    default_connection_settings = {'host'       : 'ensembldb.ensembl.org',
                                   'user'       : "anonymous",
                                   'port'       : 5306,
                                   'cursorclass': MySQLdb.cursors.SSCursor}
    default_connection_settings.update(connection_settings)


    return MySQLdb.connect(**default_connection_settings)


dbh = connect_ensembl_mysql()
start_time = time.time()

db_name = "ensembl_compara_58"
cursor = mysql_dbh.cursor()
cursor.execute("use %s" % db_name)
end_time = time.time()
print end_time -time
