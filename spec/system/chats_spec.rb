require 'rails_helper'

RSpec.describe 'チャット投稿機能',js: true,  type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @user_room = FactoryBot.create(:user_room)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # # サインインする
      sign_in(@user_room.user)

      # # ルームへページへ遷移する
      visit rooms_path

      # 作成したページに遷移する
      click_on(@user_room.room.name)

      fill_in 'chat_message', with: ''

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_path(@user_room.room_id))

      # 送信した値がブラウザに表示されていないことを確認する
      expect(page).to have_no_content(message)

      # DBに変化がないことを確認
      change(Chat, :count).by(0)
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@user_room.user)

      # # ルームへページへ遷移する
      visit rooms_path

      # 作成したページに遷移する
      click_on(@user_room.room.name)

      # 値をテキストフォームに入力する
      message = 'テスト'
      fill_in 'chat_message', with: message
      # 送信した値がDBに保存されていることを確認する
      click_button '送信'
      change(Chat, :count).by(1)


      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_path(@user_room.room_id))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(message)
    end
  end
end
