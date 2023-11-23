#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
sudo systemctl start nginx

sudo echo '
<!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>🚀 Luis cloud app 🚀</title>
            <style>
                html { color-scheme: light dark; }
                body { width: 35em; margin: 0 auto;
                font-family: Tahoma, Verdana, Arial, sans-serif; }
            </style>
        </head>
        <body>
            <h1>🚀Welcome to Luis Cloud App!🚀</h1>
            <p>If you see this page, the nginx web server is successfully installed and working.</p>
            <p>Please check my repo <a href="http://nginx.org/">here</a>.</p>
            <p>Thank you for your visit.🙏</p>
        </body>
    </html>
' > /usr/share/nginx/html/index.html