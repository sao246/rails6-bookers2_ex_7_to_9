class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  def follow(other_user)
    following << other_user unless self == other_user
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def followed_by?(user)
    followers.exists?(user.id)
  end
end
