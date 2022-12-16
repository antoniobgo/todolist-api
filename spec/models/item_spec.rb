require 'rails_helper'

## TODO: test if item is deleted after deleting associated section
describe Item do
  context 'when there is a board associated' do
    let(:user) { User.new(email: 'anemail@gmail.com', password: '12345678') }
    let(:board) { Board.new(title: 'a board title', user: user) }
    let(:section) { Section.new(title: 'a section title', board: board) }

    context 'and a title is not passed' do
      let(:item) { Item.new(section: section) }
      it 'should not be valid' do
        expect(item.valid?).to be false
      end
      it 'should not save' do
        expect(item.save).to be false
      end
    end
    context 'and title is an empty string' do
      let(:item) { Item.new(title: '', section: section) }
      it 'should be not valid' do
        expect(item.valid?).to be false
      end
      it 'should not save' do
        expect(item.save).to be false
      end
    end
    context 'and title has less than 70 characters' do
      let(:item) { Item.new(title: 'a title', section: section) }
      it 'should be valid' do
        expect(item.valid?).to be true
      end
      it 'should save' do
        expect(item.save).to be true
      end
    end
    context 'when title has exactly 70 characters' do
      let(:item) { Item.new(title: 'thisisastringwithseventycharactersthisisastringwithseventycharacters!!', section: section) }
      it 'should be valid' do
        expect(item.valid?).to be true
      end
      it 'should save' do
        expect(item.save).to be true
      end
    end
    context 'when title has more than 70 characters' do
      let(:item) { Item.new(title: 'thisisastringwithseventycharactersthisisastringwithseventycharacters!!!!!!!!', section: section) }
      it 'should be not valid' do
        expect(item.valid?).to be false
      end
      it 'should not save' do
        expect(item.save).to be false
      end
    end
    context 'when description is passed' do
      context "and is an empty string" do
        let(:item) { Item.new(title: 'a title', description: '', section: section) }
        it 'should be valid' do
          expect(item.valid?).to be true
        end
        it 'should save' do
          expect(item.save).to be true
        end
      end
      context "and it has less then 200 characters" do
        let(:item) { Item.new(title: 'a title', description: 'a normal length item description', section: section) }
        it 'should be valid' do
          expect(item.valid?).to be true
        end
        it 'should save' do
          expect(item.save).to be true
        end
      end
      context "and it has 200 characters" do
        let(:item) { Item.new(title: 'a title', description: 'a 200 length item description a 200 length item description a 200 length item description a 200 length item description a 200 length item description a 200 length item description a 200 length item de', section: section) }
        it 'should be valid' do
          expect(item.valid?).to be true
        end
        it 'should save' do
          expect(item.save).to be true
        end
      end
      context "and it has more than 200 characters" do
        let(:item) { Item.new(title: 'a title', description: 'a 200 length item description a 200 length item description a 200 length item description a 200 length item description a 200 length item description a 200 length item description a 200 length item deaaaaaaaaaaaaaaaaaa', section: section) }
        it 'should be not valid' do
          expect(item.valid?).to be false
        end
        it 'should not save' do
          expect(item.save).to be false
        end
      end
    end
  end
  context "when a item is created without a section associated" do
    let(:item) { Item.new(title: 'this is a perfectly valid item title') }
    it 'should be not valid' do
        expect(item.valid?).to be false
    end
    it 'should not save' do
        expect(item.save).to be false
    end
  end
end