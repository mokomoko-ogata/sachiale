require 'rails_helper'

RSpec.describe "買い物リスト追加", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @buy_list = FactoryBot.build(:buy_list)
  end
  context '買い物リストを追加できるとき' do
    it 'ログインしたユーザーは買い物リストを追加できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材一覧ページに移動する
      visit items_path(@user.id)
      # 買いものリスト一覧ページへのリンクがある事を確認する
      expect(page).to have_content('買い物リスト')
      # 買いものリスト一覧ページに移動する
      visit buys_list_index_path(@user.id)
      # 買いものリスト追加ページへのリンクがある事を確認する
      expect(page).to have_content('追加')
      # 買いものリスト追加ページに移動する
      visit new_buys_list_path(@user.id)
      # フォームに情報を入力する
      fill_in 'buy_list[item_name]', with: @buy_list.item_name
      fill_in 'buy_list[buy_memo]', with: @buy_list.buy_memo
      fill_in 'buy_list[amount]', with: @buy_list.amount
      select 'グラム', from: 'buy_list[unit_id]'
      # 出品するとBuyListモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { BuyList.count }.by(1)
      # 買いものリスト一覧ページに遷移することを確認する
      expect(current_path).to eq(buys_list_index_path(@user.id))
      # 買いものリスト一覧ページには先ほど追加した内容の食材が存在することを確認する（食材名）
      expect(page).to have_content(@buy_list.item_name)
      # 買いものリスト一覧ページには先ほど追加した内容の食材が存在することを確認する（メモ）
      expect(page).to have_content(@buy_list.buy_memo)
      # 買いものリスト一覧ページには先ほど追加した内容の食材が存在することを確認する（数量）
      expect(page).to have_content(@buy_list.amount)
      # 買いものリスト一覧ページには先ほど追加した内容の食材が存在することを確認する（単位）
      expect(page).to have_content('グラム')
    end
  end
  context '買いものリストを追加できないとき' do
    it 'ログインしていないと買いものリスト一覧ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 買いものリスト追加ページに遷移しようとするとログインページにリダイレクトされる
      get new_buys_list_path
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end

RSpec.describe '買い物リスト編集', type: :system do
  before do
    @buy_list1 = FactoryBot.create(:buy_list)
    @buy_list2 = FactoryBot.create(:buy_list)
  end
  context '買い物リストが編集できるとき' do
    it 'ログインしたユーザーは自分が追加した買い物リストの食材情報を編集できる' do
      # 買い物リスト1を追加したユーザーでログインする
      # 買い物リスト1を追加したユーザーの食材一覧ページに遷移する
      # 買い物リスト1を追加したユーザーの買い物リスト一覧ページに遷移する
      # 買い物リスト1の食材情報が存在する事を確認する
      # 編集ボタンがあることを確認する
      # 編集ページに遷移する
      # 既に追加済みの内容がフォームに入っていることを確認する
      # 買い物リスト情報を編集する
      # 編集してもBuyListモデルのカウントは変わらないことを確認する
      # 買い物リスト一覧ページに遷移したことを確認する
      # 買い物リスト一覧ページには先ほど変更した内容の食材が存在している(食材名)
      # 買い物リスト一覧ページには先ほど変更した内容の食材が存在している(メモ)
      # 買い物リスト一覧ページには先ほど変更した内容の食材が存在している(数量)
      # 買い物リスト一覧ページには先ほど変更した内容の食材が存在している(単位)
    end
  end

  context '買い物リストが編集できないとき' do
    it 'ログインしたユーザーは自分以外が追加した買い物リスト編集画面に遷移できない' do
      # 買い物リスト1を追加したユーザーでログインする
      # 買い物リスト1を追加したユーザーの食材一覧ページに遷移する
      # 買い物リスト1を追加したユーザーの買い物リスト一覧ページに遷移する
      # 買い物リスト2の食材情報が存在しない事を確認する
    end
    it 'ログインしていないと買い物リスト編集画面に遷移できない' do
      # トップページにいる
      # 食材一覧ページに遷移しようとするとログインページにリダイレクトされる
    end
  end
end