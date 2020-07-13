require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path
    assert_selector "h2", text: "Thermo Pi"
  end

  test "visiting the login" do
    visit new_user_session_url
    assert_selector "h2", text: "Log in"
  end

  test "login" do
    visit new_user_session_url

    fill_in "user_email", with: "ginopino.1234@libero.it"
    fill_in "user_password", with: "A1b2C3d5E6"

    click_on "Entra"

    assert_text "Benvenuto Serva"
  end

  test "user profile page" do
    visit new_user_session_url
    fill_in "user_email", with: "ginopino.1234@libero.it"
    fill_in "user_password", with: "A1b2C3d5E6"
    click_on "Entra"

    visit user_path(1)
    assert_selector "h2", text: "Profilo dell'utente Serva"
  end
end
