require 'rails_helper'

RSpec.describe "食材補充", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  context '食材補充できるとき' do
    it 'ログインしたユーザーは食材補充できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材一覧ページに移動する
      visit items_path(@user.id)
      # 食材補充ページへのリンクがある事を確認する
      expect(page).to have_content('アイテム追加')
      # 食材補充ページに移動する
      visit new_item_path
      # フォームを入力する
      attach_file 'item-image', "#{Rails.root}/public/images/test-image.png"
      fill_in 'item[item_name]', with: @item.item_name
      fill_in 'item[memo]', with: @item.memo
      fill_in 'item[amount]', with: @item.amount
      select 'グラム', from: 'item[unit_id]'
      select '2020', from: 'item_open_date_1i'
      select '1', from: 'item_open_date_2i'
      select '1', from: 'item_open_date_3i'
      select 'お肉類', from: 'item[category_id]'
      # 補充するとItemモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # 食材一覧ページに遷移する事を確認する
      expect(current_path).to eq(items_path(@user.id))
      # 食材一覧ページには先ほど補充した内容の食材が存在する事を確認する(画像)
      expect(page).to have_selector("img[src$='test-image.png']")
      # 食材一覧ページには先ほど補充した内容の食材が存在する事を確認する(食材名)
      expect(page).to have_content(@item.item_name)
      # 食材一覧ページには先ほど補充した内容の食材が存在する事を確認する(賞味期限)
      expect(page).to have_content('2020-01-01')
      # 食材一覧ページには先ほど補充した内容の食材が存在する事を確認する(数量)
      expect(page).to have_content(@item.amount)
      # 食材一覧ページには先ほど補充した内容の食材が存在する事を確認する(単位)
      expect(page).to have_content('グラム')
    end
  end

  context '食材補充できないとき' do
    it 'ログインしていないと食材一覧ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 食材補充ページに遷移しようとするとログインページにリダイレクトされる
      get new_item_path
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end
