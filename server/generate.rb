require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

class Kindler
  include Capybara::DSL

  def initialize()
    Capybara.run_server        = false
    #Capybara.app_host          = 'http://www.google.com'
    Capybara.exact             = true
    Capybara.current_driver    = :poltergeist
    Capybara.javascript_driver = :poltergeist

    Capybara.reset_sessions!

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {
        js_errors: false, # When false, Javascript errors do not get re-raised in Ruby.
        timeout: 60,
        phantomjs_logger: StringIO.new,
        logger: nil,
        window_size: [800, 600],
      })
    end
  end

  def visit_and_open
    Capybara.current_session.driver.visit('index.html')
    screenshot_and_open!
  end

 private

  def screenshot_and_open!
    `[ -f poltergeist.png ] && rm poltergeist.png`
    save_screenshot('poltergeist.png', :full => true)
    `pngcrush -c 0 -ow poltergeist.png`
    `open poltergeist.png`
  end

end

sp = Kindler.new
sp.visit_and_open

