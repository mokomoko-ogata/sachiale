require 'rails_helper'

RSpec.describe "レシピ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @blog = FactoryBot.build(:blog)
  end

  context 'レシピ投稿できるとき' do
    it 'ログインしたユーザーはレシピ投稿できる' do
      # ログインする
      # レシピ投稿ページへのリンクがある
      # レシピ投稿ページに遷移する
      # フォームに入力する
      # 投稿するとBlogモデルのカウントが1上がる
      # トップページに遷移することを確認する
      # トップページに先ほど投稿した内容のレシピが存在していることを確認する(画像)
      # トップページに先ほど投稿した内容のレシピが存在していることを確認する(レシピ名)
    end
  end

  context 'レシピ投稿できないとき' do
    it 'ログインしていないとレシピ投稿ページに遷移できない' do
      # トップページに遷移する
      # レシピ投稿ページに遷移しようとするとログインページにリダイレクトされる
    end
  end
end
