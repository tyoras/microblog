source 'https://rubygems.org'
#framework rails
gem 'rails', '3.2.1'
#accès à postgreSQL
gem 'pg'
#moteur javascipt
gem 'therubyracer', :platforms => :ruby
#encryption des mots de passe
gem 'bcrypt-ruby'
#permet de créer facilement des cas de test
gem 'faker', '1.0.1'
#pour la pagination
gem 'will_paginate', '3.0.3'
#pour la traduction
gem 'rails-i18n'
gem 'will-paginate-i18n'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '1.2.3'
end
#jquery pour rails
gem 'jquery-rails'

group :development do
  #tests d'integration pour rails
  gem 'rspec-rails'
  #execute en temps réel les tests d'integration
  gem 'guard-rspec'
  #ajoute des annotaions aux fichier de migration
  gem 'annotate', '~> 2.4.1.beta'
end

group :test do
  #tests d'integration
  gem 'rspec'
  #simulation de la page testée
  gem 'capybara'
  #notification pour les tests d'intégration
  gem 'rb-inotify'
  #notification pour les tests d'intégration
  gem 'libnotify'
  #execute en temps réel les tests d'integration
  gem 'guard-spork'
  #gestion de l'instance de rails
  gem 'spork'
  #permet de créer des objets dans les tests d'intégration
  gem 'factory_girl_rails', '1.4.0'
  #autre type de tests d'integration
  gem 'cucumber-rails', '1.2.1'
  #permet de nettoyer la base après les tests
  gem 'database_cleaner', '0.7.0'
end