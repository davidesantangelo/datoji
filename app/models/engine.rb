class Engine
  REDIS_NAMESPACE = 'datoji'.freeze

  private_class_method def self.redis
    @redis ||= Redis.new
  end
end
