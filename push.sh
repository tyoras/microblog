rake assets:clean
RAILS_ENV=production bundle exec rake assets:precompile
git add public/assets
git commit -am "precompile assets"
git push
git push heroku
