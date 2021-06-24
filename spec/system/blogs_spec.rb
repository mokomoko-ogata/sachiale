require 'rails_helper'

RSpec.describe "レシピ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @blog = FactoryBot.build(:blog)
  end

  context 'レシピ投稿できるとき' do
    it 'ログインしたユーザーはレシピ投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # レシピ投稿ページへのリンクがある
      expect(page).to have_content('投稿する')
      # レシピ投稿ページに遷移する
      visit new_blog_path
      # フォームに入力する
      attach_file 'item-image', "#{Rails.root}/public/images/test-image.png"
      fill_in 'blog[recipe_name]', with: @blog.recipe_name
      fill_in 'blog[explain]', with: @blog.explain
      fill_in 'blog[price]', with: @blog.price
      # 投稿するとBlogモデルのカウントが1上がる
      expect do
        find('input[name="commit"]').click
      end.to change { Blog.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページに先ほど投稿した内容のレシピが存在していることを確認する(画像)
      expect(page).to have_selector("img[src$='test-image.png']")
      # トップページに先ほど投稿した内容のレシピが存在していることを確認する(レシピ名)
      expect(page).to have_content(@blog.recipe_name)
    end
  end

  context 'レシピ投稿できないとき' do
    it 'ログインしていないとレシピ投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # レシピ投稿ページに遷移しようとするとログインページにリダイレクトされる
      get new_blog_path
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end

RSpec.describe 'レシピ編集' type: :system do
  before do
    @blog1 = FactoryBot.create(:blog)
    @blog2 = FactoryBot.create(:blog)
  end
  context 'レシピが編集できるとき' do
    it 'ログインしたユーザーは自分が投稿したレシピを編集できる' do
      # レシピ1を投稿したユーザーでログインする
      # レシピ1の詳細画面に遷移する
      # 編集ボタンがあることを確認する
      # 既に投稿済みの内容がフォームに入っていることを確認する
      # レシピを編集する
      # 編集してもBlogモデルのカウントは変わらない
      # レシピ詳細ページに遷移したことを確認する
      # 詳細ページには先ほど変更した内容のレシピが存在している(画像)
      # 詳細ページには先ほど変更した内容のレシピが存在している(レシピ名)
      # 詳細ページには先ほど変更した内容のレシピが存在している(費用)
      # 詳細ページには先ほど変更した内容のレシピが存在している(説明)
    end
  end

  context 'レシピが編集できないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレシピの編集画面には遷移できない' do
      # レシピ1を投稿したユーザーでログインする
      # レシピ2のレシピ詳細ページに遷移する
      # 編集ボタンが無い事を確認する
    end
    it 'ログインしていないとレシピ編集画面には遷移できない' do
      # トップページにいる
      # レシピ1の詳細ページに遷移する
      # 編集ボタンが無い事を確認する
      # レシピ2の詳細ページに遷移する
      # 編集ボタンが無い事を確認する
    end
  end
end