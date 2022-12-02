class Book < ApplicationRecord
 
 belongs_to :user ,optional: true
  validates:title,presence: true,length: { minimum: 1, maximum: 200 }
  validates:body, presence: true,length: { minimum: 1, maximum: 200 }
  
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :favorited_users,through: :favorites,source: :user
  has_many :book_tags, dependent: :destroy
  has_many :tags,through: :book_tags, dependent: :destroy
  
   scope :latest, -> {order(created_at: :desc)}
   scope :old, -> {order(created_at: :asc)}
   scope :score_count, -> {order(score: :desc)}
   
  
  
  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end
  
 def save_tags(savebook_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今bookが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - savebook_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = savebook_tags - current_tags
		
    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
		
    # Create new taggings:
    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << book_tag
    end
 end
  
   
end


  # scope :sort_books, -> (sort) { order(sort[:sort]) }
  #    scope :sort_list, -> {
  #    {
  #      "並び替え" => "",
  #      "星の多い順" => "score desc", 
  #      "作成の新しい順" => "updated_at DESC",
  #    }
  #  }