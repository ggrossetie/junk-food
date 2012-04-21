# config/initializers/mongo.rb

db_config = YAML::load(File.read(File.join(Rails.root, "/config/mongo.yml")))

if db_config[Rails.env] && db_config[Rails.env]['adapter'] == 'mongodb'
  mongo = db_config[Rails.env]
  host = mongo['host'] || 'localhost'
  port = mongo['port'] || 27017
  database = mongo['database']
  uri = mongo['uri'] || 'mongodb://' + host + ':' + port + '/' + database
  config = URI.parse(uri)

  MongoMapper.connection = Mongo::Connection.new(config.host, config.port)
  MongoMapper.database = config.path.gsub(/^\//, '')
  MongoMapper.database.authenticate(config.user, config.password) if config.user
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
 