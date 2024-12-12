# app/controllers/metrics_controller.rb
class MetricsController < ApplicationController
  def index
    output = PrometheusExporter.registry.metrics.map do |metric|
      # Manually format the metric in Prometheus text exposition format
      metric_name = metric.name
      docstring = metric.docstring

      # Prepare the HELP and TYPE lines
      help_line = "# HELP #{metric_name} #{docstring}"
      type_line = "# TYPE #{metric_name} counter"

      # Get the metric values
      value_lines = metric.values.map do |labels, value|
        # Format labels if present
        label_str = labels.any? ?
          "{#{labels.map { |k,v| "#{k}=\"#{v}\"" }.join(',')}}" :
          ''

        "#{metric_name}#{label_str} #{value}"
      end

      # Combine all parts
      [help_line, type_line, value_lines].flatten.join("\n")
    end.join("\n")

    render plain: output, content_type: 'text/plain'
  end
end
