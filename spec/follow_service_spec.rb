require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FollowService" do

  describe "POST to /users/:id/follows" do
    before do
      user_id = 1
      follower_id = 2
      post "users/#{user_id}/follows", { :follower_id => follower_id }
    end

    it "should return a 201" do
      expect(last_response.status).to eq(201)
    end

    it "should return content type of application/json" do
      expect(last_response.content_type).to eq("application/json")
    end

    it "should return a valid JSON string with the newly created follow" do
      expect(proc { JSON(last_response.body) }).to_not raise_error
    end

    it "should store the follow in the database" do
      expect(Follow.count).to eq(1)
    end
  end

  describe "GET to /users/:id/follows" do 
    before do
      @lianne = User.create!
      stephen_fry = User.create!

      Follow.create!(:followed_id => stephen_fry.id, :follower_id => @lianne.id)

      get "/users/#{stephen_fry.id}/followers"
    end

    it "should return a 200" do
      expect(last_response.status).to eq(200)
    end

    it "should return content type of application/json" do
      expect(last_response.content_type).to eq("application/json")
    end

    it "should return a valid JSON string with all the followers" do
      expect(proc { 
        user_json = JSON(last_response.body) 
        expect(user_json).to eq( [{ "id" => @lianne.id }] )
      }).to_not raise_error
    end

  end

end
