require 'spec_helper'
require 'active_record/relations_annotations'
require 'support/dummy'

RSpec.describe ActiveRecord::RelationsAnnotations do
  subject { Dummy.where(name: nil) }

  it "creates dummy correctly" do
    expect{Dummy.create}.not_to raise_error
  end

  describe "#annotated" do

    it "is always a relation" do
      expect(subject.annotated.class).to be < ActiveRecord::Relation
    end

  end

  describe "#annotate" do

    it "can annotate fetched relation" do
      expect{subject.annotate(foo: 'bar')}.not_to raise_error
    end

    it "is chainable" do
      expect{subject.annotate(foo: 'bar').where(name: 'baz')}.not_to raise_error
    end

    it "keeps annotation when adding conditions to query" do
      expect(
        subject.annotate(foo: 'bar').where(name: 'baz').annotations.foo
      ).to eq 'bar'
    end

    it "is always a relation" do
      expect(subject.annotate(foo: 'bar').class).to be < ActiveRecord::Relation
    end

  end

  describe "#annotations" do

    it "contains annotated values" do
      expect(
        subject.annotate(foo: 'bar').annotations.foo
      ).to eq 'bar'
    end

    it "has nil values when annotation not present" do
      expect(subject.annotations[:foo]).to be_nil
    end

  end

end
