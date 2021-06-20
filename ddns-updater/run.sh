#!/bin/bash

myip=$(curl -s "https://api.ipify.org")

git clone "https://$GIT_USER:$GIT_PASSWORD@$GIT_REPOSITORY" repo
git config --global user.email "bot@ddns.com"
git config --global user.name "DDNS bot"

cd repo/terraform

basetfname="ip_jonas_home"
desiredline="$basetfname = \"$myip\""
currentline="$(grep $basetfname terraform.tfvars)"

if ! grep -Fxq "$desiredline" terraform.tfvars; then
    echo "IP changed, needs to update it"
    sed "s/$currentline/$desiredline/" terraform.tfvars >/tmp/changed && mv /tmp/changed terraform.tfvars
    git add terraform.tfvars
    git commit -m "[DDNS-bot] Updating Jonas home ip"
    git push
else 
    echo "Nothing to do..."
fi
