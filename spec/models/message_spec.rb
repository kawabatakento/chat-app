require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'contentとimageが存在していれば保存できる' do
        expect(@message.valid?).to eq true
      end
      it 'contentが空でも保存できる' do
        @message.content = ""
        expect(@message.valid?).to eq true
      end
      it 'imageが空でも保存できる' do
        @message.image = nil
        expect(@message.valid?).to eq true
      end
    end
    context 'メッセージが投稿できない場合' do
      it 'contentとimageが空では保存できない' do
        @message.content = ""
        @message.image = nil
        expect(@message.valid?).to eq false
        expect(@message.errors[:content]).to include("can't be blank")
      end
      it 'roomが紐付いていないと保存できない' do
        @message.room = nil
        expect(@message.valid?).to eq false
        expect(@message.errors[:room]).to include("must exist")
      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        expect(@message.valid?).to eq false
        expect(@message.errors[:user]).to include("must exist")
      end
    end
  end
end
