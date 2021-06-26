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

RSpec.describe 'レシピ編集', type: :system do
  before do
    @blog1 = FactoryBot.create(:blog)
    @blog2 = FactoryBot.create(:blog)
  end
  context 'レシピが編集できるとき' do
    it 'ログインしたユーザーは自分が投稿したレシピを編集できる' do
      # レシピ1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @blog1.user.email
      fill_in 'user[password]', with: @blog1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # レシピ1の詳細画面に遷移する
      visit blog_path(@blog1.id)
      # 編集ボタンがあることを確認する
      expect(page).to have_content('レシピの編集')
      # 編集ページに遷移する
      visit edit_blog_path(@blog1.id)
      # 既に投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq(@blog1.recipe_name)
      expect(
        find('#item-info').value
      ).to eq(@blog1.explain)
      expect(
        find('#item-price').value
      ).to eq(@blog1.price.to_s)
      # レシピを編集する
      attach_file 'item-image', "#{Rails.root}/public/images/test-image.png"
      fill_in 'blog[recipe_name]', with: "#{@blog1.recipe_name}+編集したテキスト"
      fill_in 'blog[explain]', with: "#{@blog1.explain}+編集したテキスト"
      fill_in 'blog[price]', with: (@blog1.price + 2000).to_s
      # 編集してもBlogモデルのカウントは変わらない
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # レシピ詳細ページに遷移したことを確認する
      expect(current_path).to eq(blog_path(@blog1.id))
      # 詳細ページには先ほど変更した内容のレシピが存在している(画像)
      expect(page).to have_selector("img[src$='test-image.png']")
      # 詳細ページには先ほど変更した内容のレシピが存在している(レシピ名)
      expect(page).to have_content("#{@blog1.recipe_name}+編集したテキスト")
      # 詳細ページには先ほど変更した内容のレシピが存在している(費用)
      expect(page).to have_content((@blog1.price + 2000).to_s)
      # 詳細ページには先ほど変更した内容のレシピが存在している(説明)
      expect(page).to have_content("#{@blog1.explain}+編集したテキスト")
    end
  end

  context 'レシピが編集できないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレシピの編集画面には遷移できない' do
      # レシピ1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @blog1.user.email
      fill_in 'user[password]', with: @blog1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # レシピ2のレシピ詳細ページに遷移する
      visit blog_path(@blog2.id)
      # 編集ボタンが無い事を確認する
      expect(page).to have_no_content('レシピの編集')
    end
    it 'ログインしていないとレシピ編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # レシピ1の詳細ページに遷移する
      visit blog_path(@blog1.id)
      # 編集ボタンが無い事を確認する
      expect(page).to have_no_content('レシピの編集')
      # レシピ2の詳細ページに遷移する
      visit blog_path(@blog2.id)
      # 編集ボタンが無い事を確認する
      expect(page).to have_no_content('レシピの編集')
    end
  end
end

RSpec.describe 'レシピ削除', type: :system do
  before do
    @blog1 = FactoryBot.create(:blog)
    @blog2 = FactoryBot.create(:blog)
  end
  context 'レシピが削除できるとき' do
    it 'ログインしたユーザーは自分が投稿したレシピの削除ができる' do
      # レシピ1を投稿したユーザーでログインする
      # レシピ1の詳細ページに遷移する
      # 削除ボタンがある
      # 投稿を削除するとレコードのカウントが1減る事を確認する
      # トップページに遷移した事を確認する
      # トップページにはレシピ1の内容が存在しない
    end
  end

  context 'レシピが削除できないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレシピの削除ができない' do
      # レシピ1を投稿したユーザーでログインする
      # レシピ2の詳細ページに遷移する
      # 削除ボタンが無いことを確認する
    end

    it 'ログインしていないとレシピの削除ボタンがない' do
      # トップページに移動
      # レシピ1の詳細ページに移動する
      # 削除ボタンはない
      # レシピ2の詳細ページに移動する
      # 削除ボタンはない
    end
  end
end