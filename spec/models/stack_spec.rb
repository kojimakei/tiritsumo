require 'rails_helper'

RSpec.describe Stack, type: :model do
  before do
    @stack = FactoryBot.build(:stack)
  end

  describe 'ちりつもの保存' do
    context 'ちりつもが投稿できる場合' do
      it '日付とテキストがあれば投稿できる' do
        expect(@stack).to be_valid
      end
      it '取り組み時間が空でも保存できること' do
        @stack.work_time_id = nil
        expect(@stack).to be_valid
      end
      it '達成可否が空でも保存できること' do
        @stack.achieved = nil
        expect(@stack).to be_valid
      end
    end
    context 'ツイートが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @stack.text = ''
        @stack.valid?
        expect(@stack.errors.full_messages).to include("Textを入力してください")
      end    
      it '日付が空では投稿できない' do
        @stack.date = ''
        @stack.valid?
        expect(@stack.errors.full_messages).to include("Dateを入力してください")
      end     
      it 'ユーザーが紐付いていなければ投稿できない' do
        @stack.user = nil
        @stack.valid?
        expect(@stack.errors.full_messages).to include('Userを入力してください')
      end
      it 'dateは本日より過去でなければ投稿できない' do
        @stack.date = '3000-01-01 15:00:00'
        @stack.valid?
        expect(@stack.errors.full_messages).to include('Dateは過去の日付、もしくは本日の日付を選択してください')    
      end
      it 'テキストは20文字以下でなければ投稿できない' do
        @stack.text = 'aaaaaaaaaaaaaaaaaaaaa'
        @stack.valid?
        expect(@stack.errors.full_messages).to include('Textは20文字以内で入力してください')    
      end    
    end
  end
end
