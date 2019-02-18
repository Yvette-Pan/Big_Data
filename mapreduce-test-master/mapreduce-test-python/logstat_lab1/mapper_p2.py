#!/usr/bin/python
# --*-- coding:utf-8 --*--
import re
import sys
import os


start = int(os.environ['param_h0'])
end = int(os.environ['param_h1'])


pat = re.compile('(?P<ip>\d+[.]\d+[.]\d+[.]\d+).*?\d{4}:(?P<hour>\d{2}):\d{2}.*? ')

for line in sys.stdin:
    match = pat.search(line)
    if match:
        if ((int(match.group('hour')) >= start) & (int(match.group('hour')) < end)):
            print('%s\t%s' % ('[' + match.group('hour') + ':00' + ']' + match.group('ip'), 1))


