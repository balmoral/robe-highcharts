require 'robe/server'

class App < Robe::Server::App

  task :time do
    Time.now.to_s
  end
  
  def self.configure
    config.client_app_rb_path = 'highcharts-example/client/app.rb'
    config.title = 'RoBE Highcharts Example'

    # config.source_maps = false

    config.add_opal_unaware_gems(
      %w(
        opal-highcharts
      )
    )

    config.js_file_order = %w(
      highstock.src.js
    )

    config.html_literal_head = <<-HTML
      <meta charset="utf-8">
      <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
      <meta http-equiv="x-ua-compatible" content="ie=edge"/>  
      <link rel="icon" href="assets/images/favicon32.png" type="image/x-icon">
      <link rel="shortcut icon" href="assets/images/favicon32.png" type="image/x-icon">
      <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic,500,500italic,700,700italic,900,900italic&subset=latin,latin-ext" />
      <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto+Condensed:300,300italic,400,400italic,700,700italic&subset=latin,latin-ext" />
      <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700&subset=latin,latin-ext" />
      <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Material+Icons" />
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
      <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    HTML
  end
end