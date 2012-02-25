RAILS_ENV=production bundle exec rake assets:precompile
git add .
git commit -am "precompile css"
git push
git push heroku
