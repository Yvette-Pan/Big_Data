#!/usr/bin/python
# --*-- coding:utf-8 --*--
import re
import sys
import numpy as np


start = sys.argv[1].split('-')[0]
end = sys.argv[1].split('-')[1]

if len(sys.argv) < 2:
    print "Pattern not found"
    sys.exit()

hour_range = []
for hour in range(start,end + 1,1):
    if hour < 10:
        hour = '0'+ str(hour)
    else:
        hour = str(hour)
    hour_range.append(hour)


pat = re.compile('(?P<ip>\d+.\d+.\d+.\d+).*?\d{4}:(?P<hour>\d{2}):\d{2}.*? ')

for line in sys.stdin:
    match = pat.search(line)
    if match:
        if match.group('hour') in hour_range:
            print('%s\t%s' % ('[' + match.group('hour') + ':00' + ']' + match.group('ip'), 1))



