class Message < ApplicationRecord

  belongs_to :user
  belongs_to :group
  
  mount_uploader :image, ImageUploader

  #　テキストもしくは写真をインプットしなくてはいけない
  # テキストが未入力の場合、イメージに対するバリデーション
  validates :image, presence: true, 
            if: Proc.new { |message| message.text.blank? }
  validates :group_id, :user_id, 
            presence: true
end
