module SalesforceIntegration
  class Base
    attr_accessor :payload, :config

    def initialize(payload, config)
      @payload = payload.with_indifferent_access
      @config = config
    end

    def contact_service
      @contact_service ||= Service::Contact.new(config)
    end

    def product_service
      @product_service ||= Service::Product.new(config)
    end
  end
end
