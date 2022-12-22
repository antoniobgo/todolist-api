# frozen_string_literal: true

require 'rails_helper'

## TODO: test if board is deleted after deleting associated user
describe Board do
  context 'when there is an user associated' do
    let(:user) { User.new(email: 'anemail@gmail.com', password: '12345678') }

    context 'and a title is not passed' do
      let(:board) { Board.new(user:) }
      it 'should not be valid' do
        expect(board.valid?).to be false
      end
      it 'should not save' do
        expect(board.save).to be false
      end
    end
    context 'and title is an empty string' do
      let(:board) { Board.new(title: '', user:) }
      it 'should be not valid' do
        expect(board.valid?).to be false
      end
      it 'should not save' do
        expect(board.save).to be false
      end
    end
    context 'and title has less than 70 characters' do
      let(:board) { Board.new(title: 'a title', user:) }
      it 'should be valid' do
        expect(board.valid?).to be true
      end
      it 'should save' do
        expect(board.save).to be true
      end
    end
    context 'when title has exactly 70 characters' do
      let(:board) do
        Board.new(title: 'thisisastringwithseventycharactersthisisastringwithseventycharacters!!', user:)
      end
      it 'should be valid' do
        expect(board.valid?).to be true
      end
      it 'should save' do
        expect(board.save).to be true
      end
    end
    context 'when title has more than 70 characters' do
      let(:board) do
        Board.new(title: 'thisisastringwithseventycharactersthisisastringwithseventycharacters!!!!!!!!', user:)
      end
      it 'should be not valid' do
        expect(board.valid?).to be false
      end
      it 'should not save' do
        expect(board.save).to be false
      end
    end
  end
  context 'when a board is created without an user associated' do
    let(:board) { Board.new(title: 'this is a perfectly valid board title') }
    it 'should be not valid' do
      expect(board.valid?).to be false
    end
    it 'should not save' do
      expect(board.save).to be false
    end
  end
end
