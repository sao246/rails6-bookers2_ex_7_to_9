class BookComment < ApplicationRecord
  validates :comment, presence: true

  belongs_to :user
  belongs_to :book


  def creating?
    new_record?
  end
  
  def editing?
    !new_record?
  end
end
