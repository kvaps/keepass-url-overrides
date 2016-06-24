# URL Overrides for KeePass
Here I collect url override scripts for KeePass in Linux and Windows systems.

## SSH

##### <sup>[windows]</sup> PuTTY
* ** Scheme:** `ssh`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\PuTTY\putty.exe" -ssh "{USERNAME}@{URL:RMVSCM}" -pw "{PASSWORD}"
```

##### <sup>[linux]</sup> OpenSSH Client

* ** Scheme:** `ssh`
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

##### <sup>[windows]</sup> MSTSC

* ** Scheme:** `rdp`
* **Command:**
```
cmd://cmd /c "cmdkey /generic:TERMSRV/{URL:RMVSCM} /user:{USERNAME} /pass:{PASSWORD} && mstsc /v:{URL:RMVSCM} && timeout /t 5 /nobreak && cmdkey /delete:TERMSRV/{URL:RMVSCM}"
```

*Thanks Valiant from bitcollectors.com for this solution*

##### <sup>[linux]</sup> Remmina

* ** Scheme:** `rdp`
* **Command:**
```
cmd://bash -c "FILE=/tmp/connect.remmina ; echo -en '[remmina]\nname={TITLE}\nprotocol=RDP\nserver={BASE:RMVSCM}\nscale=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; remmina -c $FILE ; rm -f $FILE"
```

  More secure command:
```
cmd://bash -c "export DIR=/tmp/remmina; mkdir -p $DIR; chmod 700 $DIR; export FILE=$(mktemp -p $DIR XXXXXXXXXX --suffix=.remmina); echo -e '[remmina]\nname={TITLE}\nprotocol=RDP\nserver={BASE:RMVSCM}\nscale=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; nohup remmina -c $FILE &"
```

also we will need to install a small helper script:
```bash
curl -o /usr/local/bin/remmina-encode-password.py https://raw.githubusercontent.com/kvaps/keepass2-url-overriddes/master/remmina/remmina-encode-password.py
chmod +x /usr/local/bin/remmina-encode-password.py
```

## VNC

##### <sup>[windows]</sup> RealVNC

* ** Scheme:** `vnc`
* **Command:**
```
cmd://java -jar "{ENV_PROGRAMFILES}\tightvnc-jviewer.jar" -user="{USERNAME}" -password="{PASSWORD}" {BASE:RMVSCM}
```

Save `tightvnc-jviewer.jar` to `C:\Program Files\tightvnc-jviewer.jar`.

##### <sup>[linux]</sup> Remmina

* ** Scheme:** `vnc`
* **Command:**
```
cmd://bash -c "FILE=/tmp/connect.remmina ; echo -en '[remmina]\nname={TITLE}\nprotocol=VNC\nserver={BASE:RMVSCM}\nscale=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; remmina -c $FILE ; rm -f $FILE"
```

  More secure command:
```
cmd://bash -c "export DIR=/tmp/remmina; mkdir -p $DIR; chmod 700 $DIR; export FILE=$(mktemp -p $DIR XXXXXXXXXX --suffix=.remmina); echo -e '[remmina]\nname={TITLE}\nprotocol=VNC\nserver={BASE:RMVSCM}\nscale=1\nusername={USERNAME}\npassword='`remmina-encode-password.py {PASSWORD}` > $FILE ; nohup remmina -c $FILE &"
```

We do also need a little helper script, about which I wrote above

```bash
curl -o /usr/local/bin/remmina-encode-password.py https://raw.githubusercontent.com/kvaps/keepass2-url-overriddes/master/remmina/remmina-encode-password.py
chmod +x /usr/local/bin/remmina-encode-password.py
```

## SAMBA

##### <sup>[windows]</sup> Explorer

* ** Scheme:** `smb`
* **Command:**
```
cmd://cmd /c "net use "{URL:RMVSCM}" /user:"{USERNAME}" "{PASSWORD}" && start \\{URL:RMVSCM}"
```

##### <sup>[linux]</sup> Nautilus / Thunar / Dolphin

* ** Scheme:** `smb`
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

##### <sup>[windows]</sup> FileZilla FTP Client

* ** Scheme:** `ftp`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\FileZilla FTP Client\filezilla.exe" 'ftp://{USERNAME}:{PASSWORD}@{BASE:RMVSCM}'
```

##### <sup>[windows]</sup> Windows Explorer

* ** Scheme:** `ftp`
* **Command:**
```
cmd://"explorer.exe" 'ftp://{USERNAME}:{PASSWORD}@{BASE:RMVSCM}'
```

##### <sup>[linux]</sup> FileZilla FTP Client

* ** Scheme:** `ftp`
* **Command:**
```
cmd://filezilla 'ftp://{USERNAME}:{PASSWORD}@{BASE:RMVSCM}'
```

##### <sup>[linux]</sup> Nautilus / Thunar / Dolphin

* ** Scheme:** `smb`
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

##### <sup>[windows]</sup> TeamViewer

* ** Scheme:** `teamviewer`
* **Command:**
```
cmd://"{ENV_PROGRAMFILES_X86}\TeamViewer\TeamViewer.exe" -i "{USERNAME}" --Password "{PASSWORD}"
```

##### <sup>[linux]</sup> TeamViewer

* ** Scheme:** `teamviewer`
* **Command:**
```
cmd://teamviewer -i "{USERNAME}" --Password "{PASSWORD}"
```

## Winbox

##### <sup>[windows]</sup> Winbox

* ** Scheme:** `winbox`
* **Command:**
```
cmd://{ENV_PROGRAMFILES_X86}\winbox.exe '{BASE:RMVSCM}' '{USERNAME}' '{PASSWORD}'
```

Сохраните `winbox.exe` в `C:\Program Files (x86)\winbox.exe`.

##### <sup>[linux]</sup> Winbox

* ** Scheme:** `winbox`
* **Command:**
```
cmd://winbox '{BASE:RMVSCM}' '{USERNAME}' '{PASSWORD}'
```

*I use winbox from [AUR](https://aur.archlinux.org/packages/winbox/).*
