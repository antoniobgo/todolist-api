# frozen_string_literal: true

require 'rails_helper'

## TODO: test if section is deleted after deleting associated board
describe Section do
  context 'when there is a board associated' do
    let(:user) { User.new(email: 'anemail@gmail.com', password: '12345678') }
    let(:board) { Board.new(title: 'a title', user:) }

    context 'and a title is not passed' do
      let(:section) { Section.new(board:) }
      it 'should not be valid' do
        expect(section.valid?).to be false
      end
      it 'should not save' do
        expect(section.save).to be false
      end
    end
    context 'and title is an empty string' do
      let(:section) { Section.new(title: '', board:) }
      it 'should be not valid' do
        expect(section.valid?).to be false
      end
      it 'should not save' do
        expect(section.save).to be false
      end
    end
    context 'and title has less than 70 characters' do
      let(:section) { Section.new(title: 'a title', board:) }
      it 'should be valid' do
        expect(section.valid?).to be true
      end
      it 'should save' do
        expect(section.save).to be true
      end
    end
    context 'when title has exactly 70 characters' do
      let(:section) do
        Section.new(title: 'thisisastringwithseventycharactersthisisastringwithseventycharacters!!', board:)
      end
      it 'should be valid' do
        expect(section.valid?).to be true
      end
      it 'should save' do
        expect(section.save).to be true
      end
    end
    context 'when title has more than 70 characters' do
      let(:section) do
        Section.new(title: 'thisisastringwithseventycharactersthisisastringwithseventycharacters!!!!!!!!', board:)
      end
      it 'should be not valid' do
        expect(section.valid?).to be false
      end
      it 'should not save' do
        expect(section.save).to be false
      end
    end
  end
  context 'when a section is created without a board associated' do
    let(:section) { Section.new(title: 'this is a perfectly valid section title') }
    it 'should be not valid' do
      expect(section.valid?).to be false
    end
    it 'should not save' do
      expect(section.save).to be false
    end
  end
end
