require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '食材補充機能' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '食材補充ができるとき' do
      it 'item_name,amount,open_date,image,category_id,unit_idが存在すれば保存できる' do
        expect(@item).to be_valid
      end

      it 'item_nameが40文字以内であれば保存できる' do
        @item.item_name = 'a' * 40
        expect(@item).to be_valid
      end

      it 'memoが空でも保存できる' do
        @item.memo = ''
        expect(@item).to be_valid
      end

      it 'memoが1,000文字以内であれば保存できる' do
        @item.memo = 'a' * 1000
        expect(@item).to be_valid
      end

      it 'category_idが1以外の場合保存できる' do
        @item.category_id = 5
        expect(@item).to be_valid
      end

      it 'unit_idが1以外の場合保存できる' do
        @item.unit_id = 5
        expect(@item).to be_valid
      end

      it 'amountが半角数字の場合保存できる' do
        @item.amount = 100
        expect(@item).to be_valid
      end
    end

    context '食材補充ができないとき' do
      it 'imageが空の場合保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_nameが空の場合保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'item_nameが40文字以上の場合保存できない' do
        @item.item_name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include('Item name is too long (maximum is 40 characters)')
      end

      it 'memoが1000文字以上の場合保存できない' do
        @item.memo = 'a' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include('Memo is too long (maximum is 1000 characters)')
      end

      it 'amountが空の場合保存できない' do
        @item.amount = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Amount can't be blank")
      end

      it 'amountが全角数字の場合保存できない' do
        @item.amount = '１００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount is not a number')
      end

      it 'amountが数字以外の場合保存できない' do
        @item.amount = '百'
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount is not a number')
      end

      it 'amountが半角英数字混合では保存できない' do
        @item.amount = '2hundred'
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount is not a number')
      end

      it 'amountが半角英字の場合保存できない' do
        @item.amount = 'onehundred'
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount is not a number')
      end

      it 'open_dateが空の場合保存できない' do
        @item.open_date = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Open date can't be blank")
      end

      it 'category_idが1の場合保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'unit_idが1の場合保存できない' do
        @item.unit_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Unit must be other than 1')
      end

      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
