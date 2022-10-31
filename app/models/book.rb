class Book < ApplicationRecord
 
 belongs_to :user ,optional: true
  validates:title,presence: true,length: { minimum: 1, maximum: 200 }
  validates:body, presence: true,length: { minimum: 1, maximum: 200 }
  
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end
  
   
end
