# URL Overrides for KeePass2 in Linux
Here I collect url override scripts for keepass2 in linux system

## Remmina

### Installation

```bash
curl -o /usr/local/bin/remmina-encode-password.py https://raw.githubusercontent.com/kvaps/keepass2-url-overriddes/master/remmina/remmina-encode-password.py
chmod +x /usr/local/bin/remmina-encode-password.py
```

### Overrides

* `rdp` scheme
```
cmd://bash -c "FILE=/tmp/connect.remmina ; echo -en '[remmina]\nname={TITLE}\nprotocol=RDP\nserver={BASE:RMVSCM}\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; remmina -c $FILE ; rm -f $FILE"
```
* `vnc` scheme

```
cmd://bash -c "FILE=/tmp/connect.remmina ; echo -en '[remmina]\nname={TITLE}\nprotocol=VNC\nserver={BASE:RMVSCM}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; remmina -c $FILE ; rm -f $FILE"
```

## OpenSSH

### Installation

Install `sshpass` package

### Overrides

* `ssh` scheme
```
cmd://<your-terminal-emulator> -e 'sshpass -p {PASSWORD} ssh {USERNAME}@{BASE:RMVSCM}'
```
