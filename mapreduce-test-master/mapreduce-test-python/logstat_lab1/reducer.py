#!/usr/bin/python
# --*-- coding:utf-8 --*--

from operator import itemgetter
import sys

dict_ip_count = {}
for line in sys.stdin:
    line = line.strip()
    hour_ip, num = line.split('\t')
    try:
        num = int(num)
        dict_ip_count[hour_ip] = dict_ip_count.get(hour_ip, 0) + num
    except ValueError:
        pass


dict_hour_ipcount = {}
for hour_ip, count in dict_ip_count.items():
    hour = hour_ip[1:3]
    ip = hour_ip[7:]
    count = str(count)
    if hour not in dict_hour_ipcount.keys():
        dict_hour_ipcount[hour] = [(ip,count)]
    else:
        dict_hour_ipcount[hour].append((ip, count))


for hour, ipcount in dict_hour_ipcount.items():
    top3_ip = sorted(list(ipcount),key = lambda x:x[1], reverse=True)[:3]
    for ip, count in top3_ip:
        print('%s\t%s' % ('['+hour+':00' +']' + ip, count))










