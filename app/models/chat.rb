class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :message, presence: true, length: { maximum: 500 }
  # Devise could not find the `Warden::Proxy` instance on your request environmentの対策
  def template
    ApplicationController.render_with_signed_in_user(user, partial: 'chats/chat', locals: { chat: self })
  end
end
