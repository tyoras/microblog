#encoding: utf-8
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Connexion') }
    it { should have_selector('title', text: 'Connexion') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Connexion" }

      it { should have_selector('title', text: 'Connexion') }
      it { have_error_message('Invalide') }
    	
    	describe "after visiting another page" do
			  before { click_link "Accueil" }
			  it { should_not have_selector('div.flash.error') }
			end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Se déconnecter', href: signout_path) }
      it { should_not have_link('Connexion', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Se déconnecter" }
        it { should have_link("S'identifier") }
      end
    end
  end
end