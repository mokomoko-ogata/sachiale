require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザーが新規登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      select '1930', from: 'user_birthday_1i'
      select '1', from: 'user_birthday_2i'
      select '1', from: 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change {User.count}.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが表示されたことを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      select '--', from: 'user_birthday_1i'
      select '--', from: 'user_birthday_2i'
      select '--', from: 'user_birthday_3i'
      # サインアップボタンを押してもユーザーモデルのカウントが1上がらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change {User.count}.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end
