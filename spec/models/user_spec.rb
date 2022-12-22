# frozen_string_literal: true

require 'rails_helper'

describe User do
  context 'when password or email is empty' do
    context 'password is empty' do
      let(:user) { User.new(email: 'antonio.gomes@gmail.com') }
      it 'should not be valid' do
        expect(user.valid?).to be false
      end
      it 'should not save' do
        expect(user.save).to be false
      end
    end

    context 'email is empty' do
      let(:user) { User.new(password: '123456') }
      it 'should not be valid' do
        expect(user.valid?).to be false
      end
      it 'should not save' do
        expect(user.save).to be false
      end
    end
  end

  context 'when password exists' do
    context 'and has 0 characters' do
      let(:user) { User.new(email: 'antonio.gomes@gmail.com', password: '') }
      it 'should not be valid' do
        expect(user.valid?).to be false
      end
      it 'should not save' do
        expect(user.save).to be false
      end
    end

    context 'and has less than 6 characters' do
      let(:user) { User.new(email: 'antonio.gomes@gmail.com', password: '12345') }
      it 'should not be valid' do
        expect(user.valid?).to be false
      end
      it 'should not save' do
        expect(user.save).to be false
      end
    end

    context 'and has 6 characters' do
      let(:user) { User.new(email: 'antonio.gomes@gmail.com', password: '123456') }
      it 'should be valid' do
        expect(user.valid?).to be true
      end
      it 'should save' do
        expect(user.save).to be true
      end
    end

    context 'and has 7 characters ' do
      let(:user) { User.new(email: 'antonio.gomes@gmail.com', password: '1234567') }
      it 'should be valid' do
        expect(user.valid?).to be true
      end
      it 'should save' do
        expect(user.save).to be true
      end
    end

    context 'and has more than 72 characters' do
      let(:user) do
        User.new(email: 'antonio.gomes@gmail.com',
                 password: '1234567890123456789012345678901234567890123456789012345678901234567890123')
      end
      it 'should be valid' do
        expect(user.valid?).to be false
      end
      it 'should save' do
        expect(user.save).to be false
      end
    end
    context 'and has 72 characters' do
      let(:user) do
        User.new(email: 'antonio.gomes@gmail.com',
                 password: '123456789012345678901234567890123456789012345678901234567890123456789012')
      end
      it 'should be valid' do
        expect(user.valid?).to be true
      end
      it 'should save' do
        expect(user.save).to be true
      end
    end
  end

  context 'when email exists' do
    context 'and is an empty string' do
      let(:user) { User.new(email: '', password: '12345678') }
      it 'should not be valid' do
        expect(user.valid?).to be false
      end
      it 'should not save' do
        expect(user.save).to be false
      end
    end
    context 'and has a valid email structure with less than 70 characters' do
      let(:user) { User.new(email: 'antonio@antonio.com', password: '12345678') }
      it 'should be valid' do
        expect(user.valid?).to be true
      end
      it 'should save' do
        expect(user.save).to be true
      end
    end
    context 'and has a valid email structure with 70 characters' do
      let(:user) do
        User.new(email: 'antonioantonioantonioantonioantonioantonioantonioantonioaqwe@gmail.com',
                 password: '1234567890')
      end
      it 'should be valid' do
        expect(user.valid?).to be true
      end
      it 'should save' do
        expect(user.save).to be true
      end
    end
    context 'and has a valid email structure with more than 70 characters' do
      let(:user) do
        User.new(email: 'antonioantonioantonioantonioaadntonioantonioantonioantonioaqwe@gmail.com',
                 password: '1234567890')
      end
      it 'should be valid' do
        expect(user.valid?).to be false
      end
      it 'should save' do
        expect(user.save).to be false
      end
    end
    context 'and has an invalid email structure' do
      let(:user) { User.new(email: '@a', password: '12345678') }
      it 'should be valid' do
        expect(user.valid?).to be false
      end
      it 'should save' do
        expect(user.save).to be false
      end
    end
  end
end
