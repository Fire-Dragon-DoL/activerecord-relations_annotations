require 'ostruct'
require 'active_record'
require 'active_support/concern'
require 'active_record/relations_annotations/version'

module ActiveRecord
  module RelationsAnnotations
    extend ActiveSupport::Concern

    module ClassMethods

      def annotate(**values)
        annotated.tap do |relation|
          values.each do |key, value|
            relation.instance_variable_get(:@_annotations)[key.to_sym] = value
          end
        end
      end

      def annotations
        annotated.instance_variable_get(:@_annotations)
      end

      # This should never be explicitly called, but if done, nothing should
      # happen
      def annotated
        all.tap do |relation|
          if relation.instance_variable_get(:@_annotations).nil?
            relation.instance_variable_set(:@_annotations, OpenStruct.new)
          end
        end
      end

    end

  end
end
