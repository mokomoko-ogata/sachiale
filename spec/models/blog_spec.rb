require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'レシピ投稿機能' do
    before do
      @blog = FactoryBot.build(:blog)
    end

    context 'レシピ投稿ができるとき' do
      it 'recipe_name,explain,price,imageが存在すれば投稿できる' do
        expect(@blog).to be_valid
      end

      it 'recipe_nameが40文字以内の場合投稿できる' do
        @blog.recipe_name = 'a' * 40
        expect(@blog).to be_valid
      end

      it 'explainが2,000文字以内の場合投稿できる' do
        @blog.explain = 'a' * 2000
      end

      it 'priceが整数の場合投稿できる' do
        @blog.price = 1000
        expect(@blog).to be_valid
      end
    end

    context 'レシピ投稿できないとき' do
      it 'imageが空の場合投稿できない' do
        @blog.image = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Image can't be blank")
      end

      it 'recipe_nameが空の場合投稿できない' do
        @blog.recipe_name = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Recipe name can't be blank")
      end

      it 'recipe_nameが40文字以上の場合投稿できない' do
        @blog.recipe_name = 'a' * 50
        @blog.valid?
        expect(@blog.errors.full_messages).to include('Recipe name is too long (maximum is 40 characters)')
      end

      it 'explainが空の場合投稿できない' do
        @blog.explain = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Explain can't be blank")
      end

      it 'explainが1,000文字以上の場合投稿できない' do
        @blog.explain = 'a' * 2001
        @blog.valid?
        expect(@blog.errors.full_messages).to include('Explain is too long (maximum is 2000 characters)')
      end

      it 'priceが空の場合投稿できない' do
        @blog.price = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字の場合投稿できない' do
        @blog.price = '１００００'
        @blog.valid?
        expect(@blog.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが数字以外の場合投稿できない' do
        @blog.price = '三百円'
        @blog.valid?
        expect(@blog.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが半角英数字混合では投稿できない' do
        @blog.price = '2thousand'
        @blog.valid?
        expect(@blog.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが半角英語の場合投稿できない' do
        @blog.price = 'onethousand'
        @blog.valid?
        expect(@blog.errors.full_messages).to include('Price is not a number')
      end

      it 'userが紐づいていない場合投稿できない' do
        @blog.user = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include('User must exist')
      end
    end
  end
end
