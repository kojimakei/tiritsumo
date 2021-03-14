require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの保存' do
    context 'コメントが投稿できる場合' do
      it 'テキストがあれば投稿できる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメントが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Textが入力されていません。')
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
      it 'ちりつもが紐付いていなければ投稿できない' do
        @comment.stack = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Stackを入力してください')
      end
      it 'テキストは50文字以下でなければ投稿できない' do
        @comment.text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Textは50文字以下に設定して下さい。')
      end
    end
  end
end
