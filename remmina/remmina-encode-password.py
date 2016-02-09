#!/usr/bin/python2

import base64
import os
import re
import sys
from Crypto.Cipher import DES3
from os.path import expanduser

home = expanduser("~")
REMMINA_FOLDER = home+'/'+'.remmina/'
REMMINA_PREF = 'remmina.pref'
REGEXP_ACCOUNTS = r'[0-9]{13}\.remmina'
REGEXP_PREF = r'remmina.pref'

fs = open(REMMINA_FOLDER+REMMINA_PREF)
fso = fs.readlines()
fs.close()

for i in fso:
    if re.findall(r'secret=', i):
          REMMINAPREF_SECRET_B64 = i[len(r'secret='):][:-1]

plain = sys.argv[1].encode('utf-8')
secret = base64.b64decode(REMMINAPREF_SECRET_B64)
key = secret[:24]
iv = secret[24:]
plain = plain + b"\0" * (8 - len(plain) % 8)
cipher = DES3.new(key, DES3.MODE_CBC, iv)
result = cipher.encrypt(plain)
result = base64.b64encode(result)
result = result.decode('utf-8')

print result
