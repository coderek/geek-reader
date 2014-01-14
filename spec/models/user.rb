require "spec_helper"

describe User do
  before do
    @username = "zengqiang"
    @password = "qiang"
    @user = User.new
  end
  it "should create a user in correct way" do
    @user.save({username: @username, password: @password, password_confirmation: @password})
    @user.save({username: @username, password: @password, password_confirmation: @password})
    User.count.should == 1
  end

  it "can login user" do
    result = User.authenticate(@username, @password)
    result.should be_true
  end
end