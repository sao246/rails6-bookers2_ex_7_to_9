class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence:true
  validates :body, presence: true, if: :creating?
  validates :body, presence: true, if: :editing?
  validates :body, length: { in: 0..200 }
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  def creating?
    new_record?
  end
  
  def editing?
    !new_record?
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #基準日から1週間分のいいね数を集計するためのメソッド
  scope :by_weekly_favorites_count, -> {

    left_joins(:favorites)
      .group(:id)
      .select('books.*, COUNT(favorites.id) AS favorites_count')
      .order('COUNT(favorites.id) DESC')
  }
end
