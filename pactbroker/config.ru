require 'fileutils'
require 'logger'
require 'sequel'
require 'pact_broker'
require 'delegate'

class DatabaseLogger < SimpleDelegator
  def info *args
    __getobj__().debug(*args)
  end
end

DATABASE_CREDENTIALS = {
  adapter: "postgres",
  user: ENV['PACT_BROKER_DATABASE_USERNAME'],
  password: ENV['PACT_BROKER_DATABASE_PASSWORD'],
  host: ENV['PACT_BROKER_DATABASE_HOST'],
  database: ENV['PACT_BROKER_DATABASE_NAME']
}

app = PactBroker::App.new do | config |
  config.log_dir = "/var/log/pactbroker"
  config.auto_migrate_db = true
  config.use_hal_browser = true
  config.logger = ::Logger.new($stdout)
  config.logger.level = Logger::WARN
  config.database_connection = Sequel.connect(DATABASE_CREDENTIALS.merge(logger: DatabaseLogger.new(config.logger), encoding: 'utf8'))
end

run app
