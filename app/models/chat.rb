class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user_id, presence: true
  validates :message, presence: true, length: { maximum: 500 }

  def template
    ApplicationController.renderer.render partial: "chats/chat", locals: { chat: self }
  end
end
