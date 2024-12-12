# config/initializers/prometheus.rb
require 'prometheus/client'

module PrometheusExporter
  class << self
    def registry
      @registry ||= Prometheus::Client.registry
    end

    def animal_creation_counter
      @animal_creation_counter ||= registry.counter(
        :animal_created_total,
        docstring: 'Total number of animals created'
      )
    end
  end
end
