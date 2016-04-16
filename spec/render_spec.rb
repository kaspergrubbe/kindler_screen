require 'spec_helper'

require 'dimensions'

LANDSCAPE_DIMENSIONS = [800,600]
PORTRAIT_DIMENSIONS  = [600,800]

def dimensions_for(file)
  width, height = [Dimensions.width(file),Dimensions.height(file)]
end

RSpec.describe "Kindler rendering" do
  before(:all) do
    @output_dir = Dir.mktmpdir('kindler')
  end

  it "should create the file and default to landscape" do
    output_file = "#{@output_dir}/render_output.png"

    k = Kindler.new.process!(template_path: 'spec/templates/simple.haml',
                             image_output_path: output_file)

    expect(k).to                                   eq true
    expect(File.exist?(output_file)).to    eq true

    expect(dimensions_for(output_file)).to eq(LANDSCAPE_DIMENSIONS)
  end

  it "should render in portrait mode" do
    output_file = "#{@output_dir}/portrait.png"

    k = Kindler.new(orientation: 'portrait').process!(template_path: 'spec/templates/simple.haml',
                                                      image_output_path: output_file)

    expect(dimensions_for(output_file)).to eq(PORTRAIT_DIMENSIONS)
  end

  it "should render in landscape mode" do
    output_file = "#{@output_dir}/landscape.png"

    k = Kindler.new(orientation: 'landscape').process!(template_path: 'spec/templates/simple.haml',
                                                       image_output_path: output_file)

    expect(dimensions_for(output_file)).to eq(LANDSCAPE_DIMENSIONS)
  end

  it "should render the weather example in landscape mode", focus:true do
    output_file = "#{@output_dir}/weather.png"

    k = Kindler.new(orientation: 'portrait').process!(template_path: 'spec/templates/weather.haml',
                                                       image_output_path: output_file)

    `open #{output_file}`
  end
end
