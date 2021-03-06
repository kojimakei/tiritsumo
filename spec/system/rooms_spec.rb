require 'rails_helper'

RSpec.describe 'ルームの作成機能',js: true, type: :system do
  before do
    @user_room = FactoryBot.create(:user_room)
  end

  it '部屋作成が可能', js: true do
    # サインインする
    sign_in(@user_room.user)

    # # ルームへページへ遷移する
    visit rooms_path

    # 正しい部屋情報を入力する
    fill_in 'room_name', with: 'name'
    fill_in 'room_habit', with: 'habit'

    # 部屋作成をクリックすると、ルームモデルのカウントが1上がる
    click_button 'ルーム作成'
    change(Room, :count).by(1)
    # トップページに遷移していることを確認する
    expect(current_path).to eq(rooms_path)
  end

  it '部屋作成が不可能' do
    # サインインする
    sign_in(@user_room.user)

    # # ルームへページへ遷移する
    visit rooms_path

    # 部屋情報を空白で送信
    fill_in 'room_name', with: ''
    fill_in 'room_habit', with: ''

    # 部屋作成をクリックすると、ルームモデルのカウントは変化なし
    click_button 'ルーム作成'
    change(Room, :count).by(0)
    # トップページに遷移していることを確認する
    expect(current_path).to eq(rooms_path)
  end
end
