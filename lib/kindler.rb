require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'haml'

class Kindler
  include Capybara::DSL

  def initialize(options = {})
    window_size = case options.fetch(:orientation, 'landscape')
    when 'landscape'
      [800, 600]
    when 'portrait'
      [600, 800]
    else
      raise 'Wrong input supplied, orientation should be either landscape or portrait'
    end

    Capybara.register_driver(:poltergeist) do |app|
      Capybara::Poltergeist::Driver.new(app, {
        js_errors:        false, # When false, Javascript errors do not get re-raised in Ruby.
        timeout:          60,
        phantomjs_logger: StringIO.new,
        logger:           nil,
        window_size:      window_size,
      })
    end

    @user_agent = Capybara::Session.new(:poltergeist)
  end

  def process!(template_path:, image_output_path:)
    render_template(template_path, 'test.html')
    Capybara.current_session.driver.visit('test.html')
    screenshot(image_output_path)
    make_black_and_white(image_output_path)
  end

 private

  def render_template(template_path, output_path)
    template = File.read(template_path)
    html     = Haml::Engine.new(template).render

    File.open(output_path, 'w') do |file|
      file.write(html)
    end
  end

  def screenshot(image_output_path)
    save_screenshot(image_output_path)
  end

  def make_black_and_white(image_path)
    # -c 0 turns off colors
    # -ow overwrites
    `pngcrush -c 0 -ow #{image_path}`
  end
end
