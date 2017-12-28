# URL Overrides for KeePass
Here I collect url override scripts for KeePass in Linux and Windows systems.

## SSH

##### PuTTY <sup>[windows]</sup> 
* **Scheme:** `ssh`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\PuTTY\putty.exe" -ssh "{USERNAME}@{URL:HOST}" -P {BASE:PORT} -pw "{PASSWORD}" 
```

##### OpenSSH Client <sup>[linux]</sup>

* **Scheme:** `ssh`
* **Command:**
```
cmd://xterm -e sshpass -p {PASSWORD} ssh -o StrictHostKeyChecking=no {USERNAME}@{BASE:RMVSCM}
```

  More secure command:
```
cmd://bash -c 'FILE=$(mktemp) && chmod 600 $FILE && echo {PASSWORD} > $FILE ; xterm -e sshpass -f $FILE ssh -o StrictHostKeyChecking=no {USERNAME}@{BASE:RMVSCM}; rm -f $FILE'
```

You need to install `sshpass` package.
*Instead of `xterm` you can write your own favorite terminal emulator*

## RDP

##### MSTSC <sup>[windows]</sup>

* **Scheme:** `rdp`
* **Command:**
```
cmd://cmd /c "cmdkey /generic:TERMSRV/{URL:HOST} /user:{USERNAME} /pass:{PASSWORD} && mstsc /v:{BASE:RMVSCM} && cmdkey /delete:TERMSRV/{URL:HOST}"
```

*Thanks Valiant from bitcollectors.com and [DeWhite](https://habrahabr.ru/users/dewhite/) from habrahabr.ru for this solution*

##### Remmina <sup>[linux]</sup>

* **Scheme:** `rdp`
* **Command:**
```
cmd://bash -c "FILE=/tmp/connect.remmina ; echo -en '[remmina]\nname={TITLE}\nprotocol=RDP\nserver={BASE:RMVSCM}\nscale=1\nviewmode=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; remmina -c $FILE ; rm -f $FILE"
```

  More secure command:
```
cmd://bash -c "export DIR=/tmp/remmina; mkdir -p $DIR; chmod 700 $DIR; export FILE=$(mktemp -p $DIR XXXXXXXXXX --suffix=.remmina); echo -e '[remmina]\nname={TITLE}\nprotocol=RDP\nserver={BASE:RMVSCM}\nscale=1\nviewmode=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; nohup remmina -c $FILE &"
```

also we will need to install a small helper script:
```bash
curl -o /usr/local/bin/remmina-encode-password.py https://raw.githubusercontent.com/kvaps/keepass2-url-overriddes/master/remmina/remmina-encode-password.py
chmod +x /usr/local/bin/remmina-encode-password.py
```

## VNC

##### RealVNC <sup>[windows]</sup>

* **Scheme:** `vnc`
* **Command:**
```
cmd://java -jar "{ENV_PROGRAMFILES}\tightvnc-jviewer.jar" -user="{USERNAME}" -password="{PASSWORD}" {BASE:RMVSCM}
```

Save `tightvnc-jviewer.jar` to `C:\Program Files\tightvnc-jviewer.jar`.

##### Remmina <sup>[linux]</sup>

* **Scheme:** `vnc`
* **Command:**
```
cmd://bash -c "FILE=/tmp/connect.remmina ; echo -en '[remmina]\nname={TITLE}\nprotocol=VNC\nserver={BASE:RMVSCM}\nscale=1\nviewmode=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; remmina -c $FILE ; rm -f $FILE"
```

  More secure command:
```
cmd://bash -c "export DIR=/tmp/remmina; mkdir -p $DIR; chmod 700 $DIR; export FILE=$(mktemp -p $DIR XXXXXXXXXX --suffix=.remmina); echo -e '[remmina]\nname={TITLE}\nprotocol=VNC\nserver={BASE:RMVSCM}\nscale=1\nviewmode=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; nohup remmina -c $FILE &"
```

We do also need a little helper script, about which I wrote above

```bash
curl -o /usr/local/bin/remmina-encode-password.py https://raw.githubusercontent.com/kvaps/keepass2-url-overriddes/master/remmina/remmina-encode-password.py
chmod +x /usr/local/bin/remmina-encode-password.py
```

## SAMBA

##### Explorer <sup>[windows]</sup>

* **Scheme:** `smb`
* **Command:**
```
cmd://cmd /c "net use "{BASE:RMVSCM}" /user:"{USERNAME}" "{PASSWORD}" && start \\{BASE:RMVSCM}"
```

##### Nautilus / Thunar / Dolphin <sup>[linux]</sup>

* **Scheme:** `smb`
* **Command:**
```
cmd://bash -c "echo -e '\n{PASSWORD}' | gvfs-mount 'smb://{USERNAME}@{BASE:RMVSCM}' ; nautilus 'smb://{USERNAME}@{BASE:RMVSCM}'"
```

  More secure command:
```
cmd://bash -c "echo -e '\n{PASSWORD}' | gvfs-mount 'smb://{USERNAME}@{BASE:RMVSCM}' ; nohup nautilus 'smb://{USERNAME}@{BASE:RMVSCM}' &"
```

For Thunar and Dolphin is the same command, just replace `nautilus` to `thunar` or `dolphin`.


## FTP

##### FileZilla FTP Client <sup>[windows]</sup>

* **Scheme:** `ftp`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\FileZilla FTP Client\filezilla.exe" 'ftp://{USERNAME}:{PASSWORD}@{BASE:RMVSCM}'
```

##### Windows Explorer <sup>[windows]</sup>

* **Scheme:** `ftp`
* **Command:**
```
cmd://"explorer.exe" 'ftp://{USERNAME}:{PASSWORD}@{BASE:RMVSCM}'
```

##### FileZilla FTP Client <sup>[linux]</sup>

* **Scheme:** `ftp`
* **Command:**
```
cmd://filezilla 'ftp://{USERNAME}:{PASSWORD}@{BASE:RMVSCM}'
```

##### Nautilus / Thunar / Dolphin <sup>[linux]</sup>

* **Scheme:** `smb`
* **Command:**
```
cmd://bash -c "echo -e '\n{PASSWORD}' | gvfs-mount 'ftp://{USERNAME}@{BASE:RMVSCM}' ; nautilus 'ftp://{USERNAME}@{BASE:RMVSCM}'"
```

  More secure command:
```
cmd://bash -c "echo -e '\n{PASSWORD}' | gvfs-mount 'ftp://{USERNAME}@{BASE:RMVSCM}' ; nohup nautilus 'ftp://{USERNAME}@{BASE:RMVSCM}' &"
```

For Thunar and Dolphin is the same command, just replace `nautilus` to `thunar` or `dolphin`.

## TeamViewer

##### TeamViewer <sup>[windows]</sup>

* **Scheme:** `teamviewer`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\TeamViewer\TeamViewer.exe" -i "{USERNAME}" --Password "{PASSWORD}"
```

##### TeamViewer <sup>[linux]</sup> 

* **Scheme:** `teamviewer`
* **Command:**
```
cmd://teamviewer -i "{USERNAME}" --Password "{PASSWORD}"
```

## Winbox

##### Winbox <sup>[windows]</sup>

* **Scheme:** `winbox`
* **Command:**
```
cmd://{ENV_PROGRAMFILES_X86}\winbox.exe '{BASE:RMVSCM}' '{USERNAME}' '{PASSWORD}'
```

Сохраните `winbox.exe` в `C:\Program Files (x86)\winbox.exe`.

##### Winbox <sup>[linux]</sup>

* **Scheme:** `winbox`
* **Command:**
```
cmd://winbox '{BASE:RMVSCM}' '{USERNAME}' '{PASSWORD}'
```

*I use winbox from [AUR](https://aur.archlinux.org/packages/winbox/).*


## Cisco

##### PuTTY <sup>[windows]</sup> 

* **Scheme:** `cisco`
* **Command:**
```
cmd://{ENV_PROGRAMFILES_X86}\scriptsdir\Connector_Cisco.vbs "{S:lan}" "{USERNAME}" "{PASSWORD}" "{S:enable}"
```

  Also download script [Connector_Cisco.vbs](https://raw.githubusercontent.com/kvaps/keepass-url-overrides/master/cisco/Connector_Cisco.vbs)
  Save it to: `C:\Program Files (x86)\Connector_Cisco.vbs`

    *Thanks [therb1](https://habrahabr.ru/users/therb1/) from habrahabr.ru for this solution and script*

## VSphere Client

##### VpxClient <sup>[windows]</sup> 
* **Scheme:** `vpx`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\VMware\Infrastructure\Virtual Infrastructure Client\Launcher\VpxClient.exe" -i -s {URL:RMVSCM} -u {USERNAME} -p {PASSWORD}
```
