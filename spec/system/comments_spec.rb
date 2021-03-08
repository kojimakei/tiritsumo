require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @stack = FactoryBot.create(:stack)
    @comment = Faker::Lorem.sentence
  end

  context  'ちりつも投稿にコメントができるとき'do
    it 'ログインしたユーザーはちりつも詳細ページでコメント投稿できる' do
      # ログインする
      sign_in(@stack.user)    
      # ちりつも詳細ページに遷移する
      visit stack_path(@stack)
      # フォームに情報を入力する
      fill_in 'comment_text', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      click_button "送信"
      wait_for_ajax do
      change(Comment, :count).by(1)
      end  
      # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content @comment
    end
  end
  context 'ちりつも投稿にコメントができないとき'do
    it 'コメントが空新だとコメントできない' do
      # ログインする
      sign_in(@stack.user)    
      # ちりつも詳細ページに遷移する
      visit stack_path(@stack)
      # フォームに情報を入力する
      fill_in 'comment_text', with: ''
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      click_button "送信"
      wait_for_ajax do
      change(Comment, :count).by(0)
      end  
      # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_no_content @comment
    end
  end
end

# -------------------------削除--------------------------------------
RSpec.describe 'ちりつも削除', type: :system do
  before do
    @stack1 = FactoryBot.create(:stack)
    @stack2 = FactoryBot.create(:stack)
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
  end
  context 'コメント削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したコメントの削除ができる' do
      # ログインする
      sign_in(@stack1.user)    
      # ちりつも詳細ページに遷移する
      visit stack_path(@stack1)
      # フォームに情報を入力する
      fill_in 'comment_text', with: @comment1
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      click_button "送信"
      wait_for_ajax do
      change(Comment, :count).by(1)
      end  
      # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content @comment1
      # 投稿を削除するとレコードの数が1減ることを確認する
        find('.comment_delete').click
      wait_for_ajax do
        change(Comment, :count).by(-1)
      end    
      # トップページに遷移したことを確認する
      expect(current_path).to eq stack_path(@stack1)
      # トップページにはちりつも1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@comment1.text}") 
    end
  end
  context 'コメント削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したコメントの削除ができない' do
      # ログインする
      sign_in(@stack1.user)    
      # ちりつも詳細ページに遷移する
      visit stack_path(@stack1)
      # フォームに情報を入力する
      fill_in 'comment_text', with: @comment1
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      click_button "送信"
      wait_for_ajax do
      change(Comment, :count).by(1)
      end  
      # アカウント切り替えのためログアウトする
      click_link 'ログアウト'
       # アカウント2でログインする
       sign_in(@stack2.user)    
       # 異なるユーザーが投稿した詳細ページに遷移する
       visit stack_path(@stack1)   
      #  コメント削除アイコンがないことを確認する  
       expect(page).to have_no_content '.comment_delete'
    end
  end
end