# ftp_uploader.rb

This is a small application that’ll upload some local files. Use it with cron to automatically have it upload files regularly:

`crontab -e`

```
* * * * * ruby ~/Projects/uploader/uploader.rb >> ~/Projects/uploader/uploader.log 2>&1
```