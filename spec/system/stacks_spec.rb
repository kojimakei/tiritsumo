require 'rails_helper'

RSpec.describe 'ちりつも投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @stack_text = Faker::Lorem.sentence
    @stack_date = Faker::Date.between(from: '2020-01-01', to: '2020-12-31')
  end

  context 'ちりつも投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('積み上げる')
      # 投稿ページに移動する
      visit new_stack_path
      # フォームに情報を入力する
      fill_in 'stack_date', with: @stack_date
      fill_in 'stack_text', with: @stack_text
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Stack.count }.by(1)
      # 投稿したユーザーのページに遷移することを確認する
      expect(current_path).to eq(user_path(@user))
      # 先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      # トップページに遷移する
      visit root_path
      expect(page).to have_content(@stack_text)
    end
  end
  context 'ちりつも投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('積み上げる')
    end
  end
end

# -------------------------編集--------------------------------------
RSpec.describe 'ちりつも編集', type: :system do
  before do
    @stack1 = FactoryBot.create(:stack)
    @stack2 = FactoryBot.create(:stack)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @stack1.user.email
      fill_in 'password', with: @stack1.user.password
      find('input[name="commit"]').click
      # ログインしたら、トップページに移動する
      expect(current_path).to eq(root_path)
      # 投稿したページに移動する
      visit edit_stack_path(@stack1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#stack_text').value
      ).to eq(@stack1.text)
      # 投稿内容を編集する
      fill_in 'stack_text', with: @stack1.text.to_s
      # 編集してもStackモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Stack.count }.by(0)
      # 編集したユーザーの画面に遷移したことを確認する
      expect(current_path).to eq(user_path(@stack1.user_id))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@stack1.text.to_s)
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない', js: true do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @stack1.user.email
      fill_in 'password', with: @stack1.user.password
      find('input[name="commit"]').click
      # ログインしたら、トップページに移動する
      expect(current_path).to eq(root_path)
      # 異なるユーザーが投稿したページに移動する
      visit edit_stack_path(@stack2)
      # ちりつも2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '.stack_edit', href: edit_stack_path(@stack1)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      visit root_path
      # ちりつも1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '.stack_edit', href: edit_stack_path(@stack1)
      # ちりつも2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '.stack_edit', href: edit_stack_path(@stack2)
    end
  end
end

# -------------------------削除--------------------------------------
RSpec.describe 'ちりつも削除', type: :system do
  before do
    @stack1 = FactoryBot.create(:stack)
    @stack2 = FactoryBot.create(:stack)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @stack1.user.email
      fill_in 'password', with: @stack1.user.password
      find('input[name="commit"]').click
      # ログインしたら、トップページに移動する
      expect(current_path).to eq(root_path)
      # 投稿したページに移動する
      visit stack_path(@stack1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find('.stack_delete').click
      end.to change { Stack.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # トップページにはちりつも1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content(@stack1.text.to_s)
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @stack1.user.email
      fill_in 'password', with: @stack1.user.password
      find('input[name="commit"]').click
      # ログインしたら、トップページに移動する
      expect(current_path).to eq(root_path)
      # 異なるユーザーが投稿したページに移動する
      visit edit_stack_path(@stack2)
      # ちりつも2に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '.stack_delete', href: edit_stack_path(@stack1)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      visit root_path
      # ちりつも1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '.stack_delete', href: edit_stack_path(@stack1)
      # ちりつも2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '.stack_delete', href: edit_stack_path(@stack2)
    end
  end
end
