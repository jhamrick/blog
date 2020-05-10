#!/bin/sh

bundle exec jekyll build
cd _site
rsync -vrl --delete --exclude=.htaccess . jesshamrick:public_html/