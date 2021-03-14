require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグの保存' do
    context 'タグが付与できる場合' do
      it 'タグの名前があれば投稿できる' do
        expect(@tag).to be_valid
      end
    end
  end
end
