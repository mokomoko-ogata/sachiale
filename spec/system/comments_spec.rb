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
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # レシピ詳細ページに遷移する
      visit blog_path(@blog.id)
      # フォームに入力する
      fill_in 'comment[text]', with: @comment
      # コメントを投稿するとCommentモデルのカウントが1上がる事を確認する
      expect  do
        find('input[name="commit"]').click
        sleep 5
      end.to change { Comment.count }.by(1)
      # 詳細ページに先程のコメント内容が表示されている事を確認する
      expect(page).to have_content @comment
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
