include ApplicationHelper

def signin(user)
  visit new_session_path
  fill_in "session_auth",    with: user.email
  fill_in "session_password", with: user.password
  click_button "submit"
end

def signout(user)
  click_link "Abmelden"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end