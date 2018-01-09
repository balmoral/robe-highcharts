require 'robe/client/app'

module Robe
  module Highcharts
    module Client
      class Highchart < Robe::Client::Component

        # options ias hash to be pass to direct Highcharts.
        #
        # Special handling for chart width and height:
        #   [:chart][:width] => may be specified as percentage of container/parent element, e.g. '95%'.
        #   [:chart][:height] => may be specified as percentage of width, e.g. '0.75%'
        #
        # This component will properly handle percentage sizing,
        # both at render time and when browser window is resized.
        #
        # The chart is only added to the contain/parent element once the whole page has been
        # rendered - it is only then that container sizes are known for calculating chart size.
        # The component also responds to resize events in the browser window and resizes the
        # chart accordingly.
        #
        # Fixed or default sizing does not need special handling.
        #
        def initialize(options)
          @options = options.dup
          @options[:chart] ||= {}
          @width = @options[:chart][:width] || '100%'
          @height = @options[:chart][:height] || '75%' # of width => 3:4
          @options[:chart][:width] = @options[:chart][:height] = nil
          @container = div.to_element
          app.on_rendered { render_chart }
          window.on(:resize) { when_resized }
        end

        def render
          @container
        end

        def render_chart
          trace __FILE__, __LINE__, self, __method__, " : body.width = #{body.width}"
          trace __FILE__, __LINE__, self, __method__, " : body.height = #{body.height}"
          trace __FILE__, __LINE__, self, __method__, " : @container = #{@container}"
          trace __FILE__, __LINE__, self, __method__, " : @container.width = #{@container.width}"
          trace __FILE__, __LINE__, self, __method__, " : @container.height = #{@container.height}"
          (@options[:chart] ||= {})[:renderTo] = @container
          width, height = chart_size
          @options[:chart][:width] = width
          @options[:chart][:height] = height
          @chart = Highcharts::Chart.new(@options)
        end

        def when_resized
          width, height = chart_size
          @chart.set_size(width, height, false)
        end

        private

        def chart_size
          width = if @width.is_a?(String) && @width[-1] == '%'
            (@width[0...-1].to_f * 0.01 * @container.width).truncate
          else
            @width.to_i
          end
          height = if @height.is_a?(String) && @height[-1] == '%'
            (@height[0...-1].to_f * 0.01 * width).truncate
          else
            @height.to_i
          end
          trace __FILE__, __LINE__, self, __method__, " : width=#{width} height=#{height}"
          [width, height]
        end
      end
    end
  end
end