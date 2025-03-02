class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence:true
  validates :body, presence: true, if: :creating?
  validates :body, presence: true, if: :editing?
  validates :body, length: { in: 0..200 }
  has_many :favorites, dependent: :destroy

  def creating?
    new_record?
  end
  
  def editing?
    !new_record?
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
