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

RSpec.describe '食材情報編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '食材情報が編集できるとき' do
    it 'ログインしたユーザーは自分が補充した食材の情報を編集できる' do
      # 食材1を補充したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材1を補充したユーザーの食材一覧ページに遷移する
      visit items_path(@item1.user.id)
      # 食材1の詳細画面に遷移する
      visit item_path(@item1.id)
      # 編集ボタンがある事を確認する
      expect(page).to have_content('食材の編集')
      # 編集ページに遷移する
      visit edit_item_path(@item1.id)
      # 既に補充済みの内容がフォームに入っている事を確認する
      expect(
        find('#item-name').value
      ).to eq(@item1.item_name)
      expect(
        find('#item-info').value
      ).to eq(@item1.memo)
      expect(
        find('#item_amount').value
      ).to eq(@item1.amount.to_s)
      expect(
        find('#item-amount').value
      ).to eq(@item1.unit_id.to_s)
      expect(
        find('#item-category').value
      ).to eq(@item1.category_id.to_s)
      # 食材情報を編集する
      attach_file 'item-image', "#{Rails.root}/public/images/test-image.png"
      fill_in 'item[item_name]', with: "#{@item1.item_name}+編集したテキスト"
      fill_in 'item[memo]', with: "#{@item1.memo}+編集したテキスト"
      fill_in 'item[amount]', with: (@item1.amount + 2000).to_s
      select '本', from: 'item[unit_id]'
      select '2020', from: 'item_open_date_1i'
      select '1', from: 'item_open_date_2i'
      select '1', from: 'item_open_date_3i'
      select 'お肉類', from: 'item[category_id]'
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 食材詳細ページに遷移したことを確認する
      expect(current_path).to eq(item_path(@item1.id))
      # 詳細ページには変更した内容の食材が存在している(画像)
      expect(page).to have_selector("img[src$='test-image.png']")
      # 詳細ページには変更した内容の食材が存在している(食材名)
      expect(page).to have_content("#{@item1.item_name}+編集したテキスト")
      # 詳細ページには変更した内容の食材が存在している(メモ)
      expect(page).to have_content("#{@item1.memo}+編集したテキスト")
      # 詳細ページには変更した内容の食材が存在している(保存数量)
      expect(page).to have_content((@item1.amount + 2000).to_s)
      # 詳細ページには変更した内容の食材が存在している(賞味期限)
      expect(page).to have_content('2020-01-01')
      # 詳細ページには変更した内容の食材が存在している(カテゴリー)
      expect(page).to have_content('お肉類')
    end
  end

  context '食材情報編集ができないとき' do
    it 'ログインしたユーザーは自分以外が補充した食材は表示されない' do
      # 食材1を補充したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材1を補充したユーザーの食材一覧ページに遷移する
      visit items_path(@item1.user.id)
      # 食材2は一覧に表示されていない事を確認する
      expect(page).to have_no_link href: item_path(@item2)
    end
    it 'ログインしていないと食材の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 食材一覧ページに遷移しようとするとログインページにリダイレクトされる
      get items_path
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end

RSpec.describe '食材削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '食材が削除できるとき' do
    it 'ログインしたユーザーは自分が補充した食材の削除ができる' do
      # 食材1を補充したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材1を補充したユーザーの食材一覧ページに遷移する
      visit items_path(@item1.user.id)
      # 食材1の詳細画面に遷移する
      visit item_path(@item1.id)
      # 削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 食材を削除するとItemモデルのカウントが1減ることを確認する
      expect do
        find('.item-destroy').click
      end.to change { Item.count }.by(-1)
      # 食材一覧ページに遷移したことを確認する
      expect(current_path).to eq(items_path)
      # 食材一覧ページには食材1の内容が存在しないことを確認する
      expect(page).to have_no_link href: item_path(@item1)
    end
  end
  context '食材が削除できないとき' do
    it 'ログインしたユーザーは自分以外が補充した食材の削除ができない' do
      # 食材1を補充したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材1を補充したユーザーの食材一覧ページに遷移する
      visit items_path(@item1.user.id)
      # 食材2は一覧に表示されていない事を確認する
      expect(page).to have_no_link href: item_path(@item2)
    end
    it 'ログインしていないと食材の編集画面には遷移できない' do
       # トップページに移動する
       visit root_path
       # 食材一覧ページに遷移しようとするとログインページにリダイレクトされる
       get items_path
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end

RSpec.describe '食材詳細', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '食材詳細画面に遷移できる' do
    it 'ログインしているユーザーは自分が補充した食材の詳細画面に遷移できる' do
      # 食材1を補充したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 食材1を補充したユーザーの食材一覧ページに遷移する
      visit items_path(@item1.user.id)
      # 食材1の詳細画面に遷移する
      visit item_path(@item1.id)
      # 食材の詳細が表示されていることを確認する(画像)
      expect(page).to have_selector("img[src$='test-image.png']")
      # 食材の詳細が表示されていることを確認する(食材名)
      expect(page).to have_content(@item1.item_name)
      # 食材の詳細が表示されていることを確認する(食材のメモ)
      expect(page).to have_content(@item1.memo)
      # 食材の詳細が表示されていることを確認する(保存数量)
      expect(page).to have_content(@item1.amount)
      # 食材の詳細が表示されていることを確認する(賞味期限)
      expect(page).to have_content(@item1.open_date)
      # 食材の詳細が表示されていることを確認する(カテゴリー)
      expect(page).to have_content('野菜・果物類')
    end
  end
  context '食材詳細画面に遷移できない' do
    it 'ログインしたユーザーは自分以外が補充した食材の詳細画面に遷移できない' do
      # 食材1を補充したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      # 食材1を補充したユーザーの食材一覧ページに遷移する
      visit items_path(@item1.user.id)
      # 食材2は一覧に表示されていない事を確認する
      expect(page).to have_no_link href: item_path(@item2)
    end
    it 'ログインしていないと食材詳細画面に遷移できない' do
      # トップページに移動する
      visit root_path
      # 食材一覧ページに遷移しようとするとログインページにリダイレクトされる
      get items_path
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end