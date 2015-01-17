ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', dbfile: ':memory:')
 
ActiveRecord::Schema.define do
  create_table :dummies do |t|
    t.column :name, :string
  end
end