#!/usr/bin/python

import socket
import requests
import time

def check_data(host, port):
	conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	socket.setdefaulttimeout(1)
	try:
		result = conn.connect_ex((host,port))
		conn.connect((host, port))
	except Exception as e:
		requests.post("http://example.com",
					data={'failed': (host, port)})
	conn.close()

while True:
	with open('source.txt') as file:
		for line in file:
			data = line.split(':')
			host = data[0]
			port = int(data[1].replace('\n', ''))
			check_data(host, port)
	time.sleep(60)
