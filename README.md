# Deploy
```
# db作成
heroku run rails db:migrate

# 東京都・市町村データのインポート
# local
rails prefecture:import_tokyo_cities
# heroku
heroku run rails prefecture:import_tokyo_cities
```

# Heroku
```
#login
heroku login

# deploy
git push heroku master

# get deploy url
heroku info

# confirm environment
heroku config

# set environment (can set environment by gui)
heroku config:set LINE_CHANNEL_SECRET=xxxx
heroku config:set LINE_CHANNEL_TOKEN=xxxx

# appを環境変数に追加
echo $HEROKU_APP=oya-ko

# heroku apps 変更
heroku git:remote -a oya-ko
heroku git:remote -a door-prop

# heroku task
heroku run rake patrol:tokyo_police_page

# buldpack
heroku buildpacks
heroku buildpacks:add [buildpackname]
heroku buildpacks:remove [buildpackname]
heroku buildpacks:clear

# use build packs
=== oya-ko Buildpack URLs
1. heroku/ruby
2. https://github.com/heroku/heroku-buildpack-chromedriver.git
3. https://github.com/heroku/heroku-buildpack-google-chrome.git
```
