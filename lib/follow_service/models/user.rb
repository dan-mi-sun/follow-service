class User < ActiveRecord::Base

  has_many :follows_me, :class_name => "Follow", :foreign_key => :followed_id
  has_many :follows_by_me, :class_name => 'Follow', :foreign_key => :follower_id

  has_many :followers, :class_name => "User", :through => :follows_me, :source => :follower
  has_many :users_i_follow, :class_name => "User", :through => :follows_by_me, :source => :followed
end
