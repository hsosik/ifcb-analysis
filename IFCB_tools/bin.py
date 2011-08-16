#!/usr/bin/python
import ifcb
import cgi

# script for returning a bin in JSON format given the PID

DAYS_DIRS = ['/Users/jfutrelle/dev/heidiCode1/mirror/ifcb_data_MVCO_jun06']

if __name__ == '__main__':
    pid = cgi.FieldStorage().getvalue('pid')
    print 'Content-type: application/json\n'
    print '{pid:"'+pid+'"}'