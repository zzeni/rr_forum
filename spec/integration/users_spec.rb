require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          click_button
          response.should render_template('users/new')
          response.should have_tag("div#errorExplanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        integration_sign_in( User.new )
        response.should render_template('sessions/new')
        response.should have_tag("div.flash.error", /invalid/i)
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end

      it "should change the security token on the next login" do
        user = Factory(:user)
        integration_sign_in(user)
        click_link "Sign out"
        user.password = nil
        integration_sign_in(user)
        controller.should_not be_signed_in
      end
    end

  end

  describe "admin privileges" do
    describe "delete users" do
      it "should be visible on the users page" do
        user = Factory(:user, { :email => "admin@test.com", :admin => true } )
        integration_sign_in(user)
        visit users_path
        response.should render_template('users/index')
        response.should have_tag("a", /delete/i)
      end
    end
  end

end
