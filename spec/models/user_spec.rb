# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
  described_class.new(user_name: "jhondoe",
                      password: "password")
                    }
 describe "Validations" do
    it "is not valid without user_name" do
      subject.user_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if user_name is less than 6 words" do
      subject.user_name = "four"
      expect(subject).to_not be_valid
    end

    it "is not valid if user_name is more than 40 words" do
      subject.user_name = "fourtywordslongusernameisnotallowedinthedatabase"
      expect(subject).to_not be_valid
    end

    it "is not valid if user_name already exists" do
      User.create(user_name: "username", password: 'password')
      subject.user_name = "username"
      expect(subject).to_not be_valid
    end

    it "is not valid without password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if password is less than 6 words" do
      subject.password = "four"
      expect(subject).to_not be_valid
    end

    it "is not valid if password is more than 40 words" do
      subject.password = "fourtywordslongusernameisnotallowedinthedatabase"
      expect(subject).to_not be_valid
    end

    it "is valid if password and username is supplied" do
      subject.user_name = "username"
      expect(subject).to be_valid
    end
  end

  describe "authenticate" do
    it "must return true if the password matches with database" do
      user = User.create(user_name: "username", password: 'password')
      expect(user.authenticate(subject.password)).to eq true
    end

    it "must return false if the password mismatched with database" do
      user = User.create(user_name: "username", password: 'different_password')
      expect(user.authenticate(subject.password)).to eq false
    end

    it "must return false if the password is nil" do
      user = User.create(user_name: "username", password: 'different_password')
      expect(user.authenticate(nil)).to eq false
    end
  end

  describe "encrypt_password" do
    it "must set encrypted_password in user" do
      subject.save
      expect(subject.encrypt_password).to_not eq "password"
    end
  end

  describe "record_attempt" do
    it "must increment the value of login_attempt" do
      subject.record_attempt
      expect(subject.login_attempt).to eq 1
    end
  end

  describe "reset_attempt" do
    it "must set the value of login_attempt to 0 if initial value is greater than 0" do
      subject.login_attempt = 2
      subject.save
      subject.reset_attempt
      expect(subject.login_attempt).to eq 0
    end

    it "must set the value of login_attempt to 0 if initial value is 0 or smaller" do
      subject.login_attempt = 0
      subject.save
      subject.reset_attempt
      expect(subject.login_attempt).to eq 0
    end
  end
end
