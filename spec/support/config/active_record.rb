require 'active_record'
require 'sqlite3'

# ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
) 

ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do

  create_table :dummies, force: true do |t|
    t.column :name, :string
  end

end
