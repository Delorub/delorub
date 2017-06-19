# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  parent_id        :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  text             :text
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_parent_id                            (parent_id)
#  index_comments_on_user_id                              (user_id)
#

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :parent, class_name: 'Comment'

  validates :user_id, :commentable_id, :commentable_type, :text, presence: true
end
