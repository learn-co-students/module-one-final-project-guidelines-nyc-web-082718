# require 'bundler'
# require 'active_record'
# require 'rake'
# Bundler.require
#
# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_all 'lib'

# require 'bundler'
# Bundler.require
#
#
# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite')
# require_all 'lib'

require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/development.sqlite"
)

ActiveRecord::Base.logger = nil
# ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'app'
