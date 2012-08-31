require 'spec_helper'

describe "Static pages" do

  subject { page }
  let(:user) { create :user }
  before { user.activate!; signin user }
  
  describe :home do
    before { visit home_path }
    it { should_not have_selector('title', text: '| Home') }
    it { should have_content user.nickname }
    it { should have_link("Startseite", href: root_path) }
    it { should have_link("Hilfe", href: help_path) }
    it { should have_link("Mitspieler", href: users_path) }
    it { should have_link("Profil", href: user_path(user)) }
    it { should have_link("Einstellungen", href: edit_user_path(user)) }
    it { should have_link("Abmelden", href: session_path(user)) }
    it { should have_link("Wir sind...", href: about_path) }
    it { should have_link("Kontakt", href: contact_path) }
    it { should have_selector("textarea", id: "micropost_content") }
    it { should have_selector("i", id: "Kurznachrichten aktualisieren") }
    
    describe :enter_micropost do
      10.times { fill_in "micropost_content", with: attributes_for(:micropost); click_button "commit" }
      save_and_open_page
    end
  end

end