#!/usr/bin/python
import ifcb
import cgi

DAYS_DIRS = ['/Users/jfutrelle/dev/heidiCode1/mirror/ifcb_data_MVCO_jun06']

if __name__ == '__main__':
    pid = int(cgi.FieldStorage().getvalue('pid',25))
    print 'Content-type: application/json\n'
    print '{pid:"'+pid+'"}'