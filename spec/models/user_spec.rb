require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname、email、password、password_confirmation、age_id、category_id、goal、deadline、occupation_idが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが半角英数混合の6文字以上であれば登録できる' do
        @user.password = 'test123'
        @user.password_confirmation = 'test123'
        expect(@user).to be_valid
      end
      it 'メールアドレスは@を含んでいれば登録できる' do
        @user.email = 'test@gmail.com'
        expect(@user).to be_valid
      end
      it 'imageが空でも保存できること' do
        @user.image = nil
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      # 新規登録/ユーザー情報のテスト
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nicknameを入力してください')
      end
      it 'deadlineが空では登録できない' do
        @user.deadline = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Deadlineを入力してください')
      end
      it 'goalが空では登録できない' do
        @user.goal = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Goalを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Emailを入力してください')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Emailはすでに存在します')
      end

      it 'age_idが【1】だと登録できない' do
        @user.age_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include('Ageは1以外の値にしてください')
      end
      it 'category_idが【1】だと登録できない' do
        @user.category_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include('Categoryは1以外の値にしてください')
      end
      it 'occupation_idが【1】だと登録できない' do
        @user.occupation_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include('Occupationは1以外の値にしてください')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordを入力してください')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは6文字以上で入力してください')
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Password confirmationとPasswordの入力が一致しません')
      end

      it 'passwordが数字のみの場合は登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは不正な値です')
      end
      it 'passwordがローマ字のみの場合は登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abedef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは不正な値です')
      end

      it 'passwordが全角の場合は登録できない' do
        @user.password = 'あいうえお'
        @user.password_confirmation = 'abedef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは不正な値です')
      end

      it 'deadlineが過去の日付では登録できない' do
        @user.deadline = '1000-01-01 15:00:00'
        @user.valid?
        expect(@user.errors.full_messages).to include('Deadlineは今日以降のものを選択してください')
      end
      # 新規登録/ユーザー情報のテスト終わり
    end
  end
end
