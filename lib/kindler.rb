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
    tmpfile = File.open("kindler_screen_#{(Random.new.rand * 10000).to_i}.html",'w')

    begin
      render_template(template_path, tmpfile)
      @user_agent.visit(tmpfile.path)
      screenshot(image_output_path)
      make_black_and_white(image_output_path)
    ensure
      tmpfile.close
      File.delete(tmpfile.path)
    end

    true
  end

 private

  def render_template(template_path, output_file)
    template = File.read(template_path)
    html     = Haml::Engine.new(template).render

    output_file.write(html)
    output_file.flush
    output_file.rewind
  end

  def screenshot(image_output_path)
    @user_agent.save_screenshot(image_output_path)
  end

  def make_black_and_white(image_path)
    # -c 0 turns off colors
    # -ow overwrites
    `pngcrush -c 0 -ow #{image_path}`
  end
end
