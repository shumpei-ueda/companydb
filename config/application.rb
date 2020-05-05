require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Companydb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]
    # config.autoload_paths += %W(#{config.root}/lib)

    # 特にここ！！Rails5から productionでも呼び出せるように設定しないといけない
    config.enable_dependency_loading = true

    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
  end
end
