FACEBOOK_API_VERSION = "v2.8"

Koala.config.api_version = FACEBOOK_API_VERSION

# log koala requests
unless Rails.env.production?
  Koala.http_service.faraday_middleware = Proc.new do |builder|
    # Add Faraday's logger (which outputs to your console)
    builder.use Faraday::Response::Logger

    # Add the default middleware by calling the default Proc that we just replaced
    # SOURCE CODE: https://github.com/arsduo/koala/blob/master/lib/koala/http_service.rb#L20
    Koala::HTTPService::DEFAULT_MIDDLEWARE.call(builder)
  end
end