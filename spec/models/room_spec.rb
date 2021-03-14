require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'nameの値が存在すれば登録できること' do
      expect(@room).to be_valid
    end

    it 'imageが空でも保存できること' do
      @room.image = nil
      expect(@room).to be_valid
    end

    it 'nameが空では登録できないこと' do
      @room.name = ''
      @room.valid?
      expect(@room.errors.full_messages).to include('Nameが入力されていません。')
    end
    it 'habitが空では登録できないこと' do
      @room.habit = ''
      @room.valid?
      expect(@room.errors.full_messages).to include('Habitが入力されていません。')
    end
  end
end
