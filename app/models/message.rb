class Message < ApplicationRecord

  belongs_to :user
  belongs_to :group
  
  mount_uploader :image, ImageUploader

  #　テキストもしくは写真をインプットしなくてはいけない
  validates :image, presence: true, if: Proc.new { |message| message.text.blank? }
  validates :group_id, :user_id, presence: true

  # private
  # def present_group_id_and_user_id?
  #   group_id.blank? && user_id.blank?
  # end
end
