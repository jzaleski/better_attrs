require 'spec_helper'

class SimpleAttrWriter
  attr_accessor :foo, :bar, :foo_changed => :foo_changed

  def foo_changed(old_value, new_value); end
end

describe SimpleAttrWriter do
  it 'will call `foo_changed` when `foo` is updated' do
    expect(subject).to receive(:foo_changed).with(nil, 2)

    subject.foo = 2
  end

  it 'will not call `foo_changed` when `bar` is updated' do
    expect(subject).not_to receive(:foo_changed)

    subject.bar = 2
  end

  it 'will not call `foo_changed` if `old_value` and `new_value` are the same' do
    subject.foo = 2

    expect(subject).not_to receive(:foo_changed)

    subject.foo = 2
  end
end
