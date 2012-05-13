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

      it { should_not have_link('Utilisateurs') }
      it { should_not have_link('Profil') }
      it { should_not have_link('Paramètres') }
      it { should_not have_link('Se déconnecter', href: signout_path) }
      it { should have_link('S\'identifier', href: signin_path) }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_selector('title', text: user.name) }

      it { should have_link('Utilisateurs', href: users_path) }
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Paramètres', href: edit_user_path(user)) }
      it { should have_link('Se déconnecter', href: signout_path) }
      it { should_not have_link('S\'identifier', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Se déconnecter" }
        it { should have_link("S'identifier") }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Connexion') }
        end

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Connexion') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            fill_in "Email",    with: user.email
            fill_in "Mot de passe", with: user.password
            click_button "Connexion"
          end

          describe "after signing in" do
            it "should render the desired protected page" do
              page.should have_selector('title', text: 'Modifier utilisateur')
            end
          end

          describe "when signing in again" do
             before { sign_in user }

            it "should render the default (profile) page" do
              page.should have_selector('title', text: user.name) 
            end
          end
        end

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_selector('title', text: 'Connexion') }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_selector('title', text: 'Connexion') }
        end
      end

      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { response.should redirect_to(signin_path) }          
        end
      end
    end

    describe "in the Microposts controller" do

      describe "submitting to the create action" do
        before { post microposts_path }
        specify { response.should redirect_to(signin_path) }
      end

      describe "submitting to the destroy action" do
        before do
          micropost = FactoryGirl.create(:micropost)
          delete micropost_path(micropost)
        end
        specify { response.should redirect_to(signin_path) }
      end
    end
        

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_selector('title', text: 'Accueil') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }        
      end
    end

    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:user) }

      before { sign_in admin }

      describe "submitting a DELETE request to the Users#destroy action on himself" do
        before { delete user_path(admin) }
        specify { response.should redirect_to(root_path) }        
      end
    end
  end
end