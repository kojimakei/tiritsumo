require 'rails_helper'

RSpec.describe Chat, type: :model do
  before do
    @chat = FactoryBot.build(:chat)
  end

  describe 'チャットの保存' do
    context 'チャットが投稿できる場合' do
      it 'メッセージがあれば投稿できる' do
        expect(@chat).to be_valid
      end
    end
    context 'チャットが投稿できない場合' do
      it 'messageが空では保存できないこと' do
        @chat.message = ''
        @chat.valid?
        expect(@chat.errors.full_messages).to include("Messageを入力してください")
      end
      it 'roomが紐付いていないと保存できないこと' do
        @chat.room = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include('Roomを入力してください')
      end
  
      it 'userが紐付いていないと保存できないこと' do
        @chat.user = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include('Userを入力してください')
      end 
    end
  end
end
