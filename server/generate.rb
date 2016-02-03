require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'haml'

class Kindler
  include Capybara::DSL

  def initialize(options = {})
    orientation = options.fetch(:orientation, 'landscape')

    case orientation
    when 'landscape'
      window_size = [800, 600]
    when 'portrait'
      window_size = [600, 800]
    else
      raise 'Wrong input supplied, orientation should be either landscape or portrait'
    end

    Capybara.run_server        = false
    #Capybara.app_host          = 'http://www.google.com'
    Capybara.exact             = true
    Capybara.current_driver    = :poltergeist
    Capybara.javascript_driver = :poltergeist

    Capybara.reset_sessions!

    Capybara.register_driver(:poltergeist) do |app|
      Capybara::Poltergeist::Driver.new(app, {
        js_errors: false, # When false, Javascript errors do not get re-raised in Ruby.
        timeout: 60,
        phantomjs_logger: StringIO.new,
        logger: nil,
        window_size: window_size,
      })
    end
  end

  def render_template
    template = File.read('template.haml')
    html     = Haml::Engine.new(template).render

    File.open('output.html', 'w') do |file|
      file.write(html)
    end

  end

  def visit_and_open
    Capybara.current_session.driver.visit('output.html')
    screenshot_and_open!
  end

 private

  def screenshot_and_open!
    `[ -f poltergeist.png ] && rm poltergeist.png`
    save_screenshot('poltergeist.png')
    `pngcrush -c 0 -ow poltergeist.png`
    `open poltergeist.png`
  end

end

sp = Kindler.new
sp.render_template
sp.visit_and_open

