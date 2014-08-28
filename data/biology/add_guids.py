#!/usr/bin/python

import uuid
import sqlite3

conn = sqlite3.connect("portal_mammals.sqlite")

# Though this looks horrid it is here to allow debugging without always
# resetting the database.
def run_pass(conn, sql):
    try:
        conn.execute(sql)
        conn.commit()
    except Exception as e:
        print "Skipped error " + str(e)
        pass


# Add columns to hold new GUIDs
run_pass(conn, "ALTER TABLE plots ADD COLUMN plot_guid VAR(36)")
run_pass(conn, "ALTER TABLE surveys ADD COLUMN survey_guid VAR(36)")


# Generate GUIDs for plots
for row in conn.execute("SELECT plot_id FROM plots"):
    plot_id = row[0]
    plot_guid = uuid.uuid4()
    conn.execute("UPDATE plots SET plot_guid='%s' WHERE plot_id=%s" %
                  (plot_guid, plot_id))
conn.commit()

# Generate GUIDs for surveys
for row in conn.execute("SELECT record_id FROM surveys"):
    record_id = row[0]
    # expensive, more than a minute
    survey_guid = uuid.uuid4()
    conn.execute("UPDATE surveys SET survey_guid='%s' WHERE record_id=%s" %
                  (survey_guid, record_id))
conn.commit()

# Copy tables to new ones to eliminate the old id columns
run_pass(conn, "DROP TABLE plots2")
conn.commit()
run_pass(conn, """CREATE TABLE plots2 AS 
                  SELECT plot_guid AS plot_id, plot_type 
                  FROM plots""")
conn.commit()

run_pass(conn, "DROP TABLE surveys2")
conn.commit()
run_pass(conn, """CREATE TABLE surveys2 AS 
                  SELECT s.survey_guid AS survey_id, s.month, s.day, s.year, 
                  p.plot_guid AS plot_id, s.species, s.sex, s.wgt
                  FROM surveys s LEFT JOIN plots p ON s.plot=p.plot_id""")
conn.commit()

run_pass(conn, "DROP TABLE plots")
conn.commit()
run_pass(conn, "ALTER TABLE plots2 RENAME TO plots")
conn.commit()
run_pass(conn, "DROP TABLE surveys")
conn.commit()
run_pass(conn, "ALTER TABLE surveys2 RENAME TO surveys")
conn.commit()

conn.close()
