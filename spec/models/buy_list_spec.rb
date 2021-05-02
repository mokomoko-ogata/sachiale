require 'rails_helper'

RSpec.describe BuyList, type: :model do
  describe '買い物リスト追加機能' do
    before do
      @buy_list = FactoryBot.build(:buy_list)
    end

    context '買い物リストに食材を追加できる時' do
      it 'item_name,buy_memo,amount,unit_idが存在する場合追加できる' do
        expect(@buy_list).to be_valid
      end

      it 'item_nameが40文字以内の場合追加できる' do
        @buy_list.item_name = 'a' * 40
        expect(@buy_list).to be_valid
      end

      it 'buy_memoが空でも追加できる' do
        @buy_list.buy_memo = ''
        expect(@buy_list).to be_valid
      end

      it 'amountが空でも追加できる' do
        @buy_list.amount = nil
        expect(@buy_list).to be_valid
      end

      it 'unit_idが空でも追加できる' do
        @buy_list.unit_id = ''
        expect(@buy_list).to be_valid
      end
    end

    context '買い物リストに食材を追加できない時' do
      it 'item_nameが空の場合追加できない' do
        @buy_list.item_name = ''
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include("Item name can't be blank")
      end

      it 'item_nameが40文字以上の場合追加できない' do
        @buy_list.item_name = 'a' * 41
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('Item name is too long (maximum is 40 characters)')
      end

      it 'buy_memoが1000文字以上の場合追加できない' do
        @buy_list.buy_memo = 'a' * 1001
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('Buy memo is too long (maximum is 1000 characters)')
      end

      it 'amountが全角数字では追加できない' do
        @buy_list.amount = '２００'
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('Amount is not a number')
      end

      it 'amountが数字以外では追加できない' do
        @buy_list.amount = '二百'
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('Amount is not a number')
      end

      it 'amountが半角英数字混合では追加できない' do
        @buy_list.amount = '2hundred'
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('Amount is not a number')
      end

      it 'amountが半角英字では追加できない' do
        @buy_list.amount = 'onehundred'
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('Amount is not a number')
      end

      it 'userが紐づいていないと追加できない' do
        @buy_list.user = nil
        @buy_list.valid?
        expect(@buy_list.errors.full_messages).to include('User must exist')
      end
    end
  end
end
