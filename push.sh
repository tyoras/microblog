RAILS_ENV=production bundle exec rake assets:precompile
git add public/assets
git commit -am "precompile css"
git push
git push heroku
