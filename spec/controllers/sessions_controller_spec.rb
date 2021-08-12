require "rails_helper"

RSpec.describe SessionsController, :type => :controller do
  describe "GET sign_in" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "responds to html by default" do
      get :new
      expect(response.content_type).to eq "text/html; charset=utf-8"
    end

    it "should not have a current_user" do
      get :new
      expect(@current_user).to eq(nil)
    end
  end

  describe "POST sign_in" do
    create_user
    it "has a 302 status code if user and password is correct" do
      post :create, { params: { user_name: "jhondoe", password: "password"}}
      expect(response.status).to eq(302)
    end

    it "has a 401 status code if user and password is incorrect" do
      post :create, { params: {user: { user_name: "jhondoe", password: "password_different"}}}
      expect(response.status).to eq(401)
    end

    it "has a 401 status code if user_name is nil" do
      post :create, { params: {user: { user_name: nil, password: "password_different"}}}
      expect(response.status).to eq(401)
    end
  end

  describe "DESTROY sign_up" do
    create_user
    login_user
    it "has a 302 code if user logged out" do
      delete :destroy
      expect(response.status).to eq(302)
    end
  end
end
