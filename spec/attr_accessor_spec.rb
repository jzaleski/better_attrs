require 'spec_helper'

class AttrAccessor; end

describe AttrAccessor do
  let(:klass) { subject.class }

  it 'will accept a `lambda` as a valid callback' do
    expect do
      klass.class_eval do
        attr_accessor :foo, :foo_changed => lambda { |old_value, new_value| }
      end
    end.to_not raise_error

    expect(subject).to respond_to(:foo=)
    expect(subject).to respond_to(:foo)
  end

  it 'will accept a `proc` as a valid callback' do
    expect do
      klass.class_eval do
        attr_accessor :foo, :foo_changed => proc { |old_value, new_value| }
      end
    end.to_not raise_error

    expect(subject).to respond_to(:foo=)
    expect(subject).to respond_to(:foo)
  end

  it 'will accept a `String` as a valid callback' do
    expect do
      klass.class_eval do
        attr_accessor :foo, :foo_changed => 'foo_changed'
      end
    end.to_not raise_error

    expect(subject).to respond_to(:foo=)
    expect(subject).to respond_to(:foo)
  end

  it 'will accept a `Symbol` as a valid callback' do
    expect do
      klass.class_eval do
        attr_accessor :foo, :foo_changed => :foo_changed
      end
    end.to_not raise_error

    expect(subject).to respond_to(:foo=)
    expect(subject).to respond_to(:foo)
  end
end
