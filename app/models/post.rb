class Post < ActiveRecord::Base
  validates :title, :content, :author_id, :sub_id, presence: true

  belongs_to :sub, inverse_of: :posts

  belongs_to :author,
  class_name: "User",
  foreign_key: :author_id,
  inverse_of: :posts

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
end
