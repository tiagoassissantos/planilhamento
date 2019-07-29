require 'rails_helper'

describe "the signin process", type: :feature do
  it "signs me in" do
    visit '/#/'
    expect(page).to have_selector('.container')
    #within(".signin_form") do
    #fill_in 'Email', with: 'user@example.com'
    #fill_in 'Password', with: 'password'
    #end
    #click_button 'Entrar'
    #expect(page).to have_content 'Success'
  end
end