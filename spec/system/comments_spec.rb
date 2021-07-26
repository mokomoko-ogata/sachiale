require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @blog = FactoryBot.create(:blog)
    @user = FactoryBot.create(:user)
    @comment = Faker::Lorem.sentence
  end

  context 'コメント投稿ができるとき' do
    it 'ログインしたユーザーはレシピ詳細ページでコメント投稿ができる' do
      # ログインする
      # レシピ詳細ページに遷移する
      # フォームに入力する
      # コメントを投稿するとCommentモデルのカウントが1上がる事を確認する
      # 詳細ページに先程のコメント内容が表示されている事を確認する
    end
  end

  context 'コメント投稿ができないとき' do
    it 'ログインしていないユーザーはレシピ詳細ページでコメント投稿できない' do
      # レシピ詳細ページに遷移する
      # フォームに情報を入力する
      # コメントを送信してもCommentモデルのカウントは変わらない
    end
  end
end
