require 'spec_helper'

describe "Static pages" do
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: titre(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Marmotte Blog' }
    let(:page_title) { 'Accueil' }
    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Aide' }
    let(:page_title) { 'Aide' }
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'A Propos' }
    let(:page_title) { 'A Propos' }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "A Propos"
    page.should have_selector 'title', text: titre('A Propos')
    click_link "Aide"
    page.should have_selector 'title', text: titre('Aide')
    click_link "Contact"
    page.should have_selector 'title', text: titre('Contact')
    click_link "Accueil"
    page.should have_selector 'title', text: titre('Accueil')
    click_link "S'inscrire !"
    page.should have_selector 'title', text: titre('Inscription')
  end
end