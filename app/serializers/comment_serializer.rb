class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text
  belongs_to :user
  belongs_to :post
end
