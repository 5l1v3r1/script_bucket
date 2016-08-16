#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import json
import urllib

install_path =

# first you have to be an admin
#def is_admin(): # works in Windows only
#    try:
#        result = os.listdir("C:\Windows\Temp")
#        print("\n[+] Welcome!\nThis script will guide you through the configuration of Shadowsocks-Plus, and install it to", install_path, '\n')
#    except:
#        print("\n[-] Sorry, but I reli need admin privilege to finish my job :( please run me again as admin\n")
#        input("[*] Press Enter to exit...")
#       exit(1)
#is_admin() # check

# download and install ssp
def download():
    from urllib import request
    url = "https://github.com/jm33-m0/shadowsocks-plus/releases/download/v0.1/ssp.exe"

    file_name = url.split('/')[-1]

    u = urllib.request.urlopen(url)
    f = open(file_name, 'wb')
    #meta = u.info()
    file_size = int(u.getheader("Content-Length")[0])
    print("Downloading: %s Bytes: %s" % (file_name, file_size))

    file_size_dl = 0
    block_sz = 8192
    while True:
        buffer = u.read(block_sz)
        if not buffer:
            break
        file_size_dl += len(buffer)
        f.write(buffer)
        status = r"%10d  [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
        status = status + chr(8)*(len(status)+1)
        print(status)

    f.close()
    pass

# check if we need to download and install ssp
if not os.path.exists('.\ssp.exe'):
    download()
    if not os.path.isfile("%s\ssp.exe" % install_path):
        cmd = "copy .\ssp.exe ", install_path
        os.system(cmd)
        pass
    pass


# server config
def user_input():
    config = {'server': input('Server IP: '), 'port': int(input('Server port: ')), 
              'password': input('Password: '), 'lport': int(input('Local port: '))
              }
    #print(config)
    config_json = json.dumps(config)
    #print(config_json)
    config_file = json.dumps(config, sort_keys=True, indent=4)
    with open('ssp.json', 'w') as out_file:
        out_file.write(config_file)
    pass

if not os.path.isfile('.\ssp.json'):
    user_input()
    pass


# now we pull args out of the json file
with open('.\ssp.json') as data_file:
    config_data = json.load(data_file)
    pass

server = config_data['server']
port = config_data['port']
password = config_data['password']
lport = config_data['lport']

# start ssp in background
import subprocess
print('\n[+] Starting ssp in background...\n')
ssp_call = 'ssp.exe -s %s -p %d -k %s -l %d' % (server, port, password, lport)
subprocess.Popen(ssp_call)