require 'spec_helper'

describe "Static pages" do
	let(:base_title) { "Marmotte Blog" }
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    it {should have_selector("h1", :text => 'Marmotte Blog')}
    it {should have_selector("title", :text => titre('Accueil'))}
  end

  describe "Help page" do
    before { visit help_path }
    it {should have_selector("h1", :text => 'Aide')}
    it {should have_selector("title", :text => titre('Aide'))}
  end

  describe "About page" do
    before { visit about_path }
    it {should have_selector("h1", :text => 'A Propos')}
    it {should have_selector("title", :text => titre('A Propos'))}
  end

  describe "Contact page" do
    before { visit contact_path }
    it {should have_selector("h1", :text => 'Contact')}
    it {should have_selector("title", :text => titre('Contact'))}
  end
end