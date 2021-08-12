require "rails_helper"

RSpec.describe RegistrationsController, :type => :controller do
  describe "GET sign_up" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "responds to json when given" do
      # get :new, params: { format: :json }
      # expect(response.content_type).to eq "application/json"
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

  describe "POST sign_up" do
    it "has a 200 status code" do
      post :create, { params: {user: { user_name: "johndoe", :password => "password"}}}
      expect(response.status).to eq(200)
    end

    it "has a 422 code when password is too short" do
      post :create, { params: {user: { user_name: "johndoe", :password => "pa"}}}
      expect(response.status).to eq(422)
    end

    it "has a 422 code when username is nil" do
      post :create, { params: {user: { user_name: nil, :password => "pa"}}}
      expect(response.status).to eq(422)
    end

    it "has a 422 code when password is nil" do
      post :create, { params: {user: { user_name: "username", :password => nil}}}
      expect(response.status).to eq(422)
    end

    it "has a 422 code when username already exists" do
      User.create(user_name: "User1", password: "password")
      post :create, { params: {user: { user_name: "User1", :password => "password"}}}
      expect(response.status).to eq(422)
    end
  end
end
