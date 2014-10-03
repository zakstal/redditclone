class PostSub < ActiveRecord::Base
  validates :post_id, :sub_id, presence: true
  belongs_to :post, inverse_of: :post_subs
  belongs_to :sub, inverse_of: :post_subs
end
