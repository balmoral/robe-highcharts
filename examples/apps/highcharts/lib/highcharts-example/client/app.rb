require 'robe/client/app'
require 'robe/common/state/atom'
require 'opal/highcharts'

module Robe
  class Highchart < Robe::Client::Component

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

class App < Robe::Client::App

  CHART_OPTIONS = {
    id: 'fruit',

    # highcharts options
    chart: {
      type: 'bar',
      renderTo: 'chart'
    },
    title: {
      text: 'Fruit Consumption'
    },
    xAxis: {
      categories: %w(Apples Bananas Oranges)
    },
    yAxis: {
      title: {
          text: 'Fruit eaten'
      }
    },
    series: [
      {
        name: 'Jane',
        data: [1, 0, 4]
      },
      {
        name: 'John',
        data: [5, 7, 3]
      }
    ]
  }

  CHART_ID = 'chart'

  class ChartDiv < Robe::Client::Component
    def render
      Robe::Highchart.new(CHART_OPTIONS)
    end

  end

  class Page < Robe::Client::Component
    def initialize
      # every(1000) {}
    end

    def render
      div.style(font_family: 'Helvetica')[
        h1.style(text_align: :center)[
          'RoBE => Ruby on Both Ends.'
        ],
        2.times.map {
          div[
            hr,
            div.css(:row, margin_top: 2.em)[
              4.times.map {
                div.css(:col_md_6, :col_sm_12)[
                  ChartDiv.new
                ]
              }
            ]
          ]
        }
      ]
    end

  end

  def initialize
    super Page.new
  end

end

::App.new.mount
