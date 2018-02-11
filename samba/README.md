Starting services

To provide basic file sharing through SMB start/enable smbd.service and/or nmbd.service services.The nmbd.service service may not always be required.

Tip: Instead of having the service running since boot, you can enable smbd.socket so the daemon is started on the first incoming connection. Do not forget to disable smbd.service.
Creating usershare path
Note: This is an optional feature. Skip this section if you do not need it.
"Usershare" is a feature that gives non-root users the capability to add, modify, and delete their own share definitions.

This creates the usershare directory in /var/lib/samba

```
mkdir -p /var/lib/samba/usershare
```

This creates the group sambashare:

```
groupadd -r sambashare
```

This changes the owner of the directory to root and the group to sambashare:

```
chown root:sambashare /var/lib/samba/usershare
```

This changes the permissions of the usershare directory so that users in the group sambashare can read, write and execute files:

```
chmod 1770 /var/lib/samba/usershare
```

Set the following parameters in the smb.conf configuration file:

/etc/samba/smb.conf
```
...
[global]
  usershare path = /var/lib/samba/usershare
  usershare max shares = 100
  usershare allow guests = yes
  usershare owner only = yes
  ...
```

Add your user to the sambashare group. Replace your_username with the name of your user:

```
gpasswd sambashare -a your_username
```

Restart smbd.service and nmbd.service services.

Log out and log back in. You should now be able to configure your samba share using GUI. For example, in Thunar you can right click on any directory and share it on the network. If you want to share paths inside your home directory you must make it listable for the group others.

Adding a user
Samba requires a Linux user account - you may use an existing user account or create a new one.

Although the user name is shared with Linux system, Samba uses a password separate from that of the Linux user accounts. Replace samba_user with the chosen Samba user account:

```
smbpasswd -a samba_user
```
