class Book < ApplicationRecord
 
 belongs_to :user ,optional: true
  validates:title,presence: true,length: { minimum: 1, maximum: 200 }
  validates:body, presence: true,length: { minimum: 1, maximum: 200 }
  
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  scope :sort_books, -> (sort) { order(sort[:sort]) }
     scope :sort_list, -> {
     {
       "並び替え" => "",
       "星の多い順" => "score desc", #その後ビューのタブをリンクに直す
       "作成の新しい順" => "updated_at DESC",
     }
   }
  
  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end
  
   
end
