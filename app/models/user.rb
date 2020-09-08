class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :tweets

  has_many :followed, foreign_key: 'following_id', class_name: 'Follow'
  has_many :followers, through: 'followed', source: 'user'

  def following
    User.joins(:followed).where(follows: { follower_id: id })
  end
end
