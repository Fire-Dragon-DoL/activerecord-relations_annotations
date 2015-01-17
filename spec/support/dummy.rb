require 'active_record'
require 'active_record/relations_annotations'
require 'support/config/active_record'

class Dummy < ActiveRecord::Base
  include ActiveRecord::RelationsAnnotations
end