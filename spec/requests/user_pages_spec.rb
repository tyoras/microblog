#encoding: utf-8
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'Liste des utilisateurs') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Suivant') }
      it { should have_link('2') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      it { should_not have_link('Supprimer') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Supprimer', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('Supprimer') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('Supprimer', href: user_path(admin)) }
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Inscription') }
    it { should have_selector('title', text: 'Inscription') }
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
	  before { visit user_path(user) }

	  it { should have_selector('h1',    text: user.name) }
	  it { should have_selector('title', text: user.name) }
	end

	describe "signup" do

    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "S'inscrire !" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Nom",         	with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Mot de passe", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "S'inscrire !" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "S'inscrire !" }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.flash.success', text: 'Bienvenue') }
        it { should have_link('Se déconnecter') }
      end
    end

    describe "error messages" do
      before { click_button "S'inscrire !" }

      let(:error) { 'erreurs' }

      it { should have_selector('title', text: 'Inscription') }
      it { should have_content(error) }
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
     before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Modifier utilisateur") }
      it { should have_selector('title', text: "Modifier utilisateur") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      let(:error) { '1 erreur a empêché la sauvegarde des données de l\'utilisateur:' }
      before { click_button "Mettre à jour" }

      it { should have_content(error) }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nom",          with: new_name
        fill_in "Email",        with: new_email
        fill_in "Mot de passe", with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Mettre à jour"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.flash.success') }
      it { should have_link('Se déconnecter', :href => signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end