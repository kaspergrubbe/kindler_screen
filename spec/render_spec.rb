require 'spec_helper'

require 'dimensions'

LANDSCAPE_DIMENSIONS = [800,600]
PORTRAIT_DIMENSIONS  = [600,800]

def dimensions_for(file)
  width, height = [Dimensions.width(file),Dimensions.height(file)]
end

RSpec.describe "Kindler rendering" do
  it "blah!" do
    k = Kindler.new.process!(template_path: 'spec/templates/simple.haml', image_output_path: 'render_output.png')

    expect(k).to                                   eq true
    expect(File.exist?('render_output.png')).to    eq true

    # Default is landscape-mode
    expect(dimensions_for('render_output.png')).to eq(LANDSCAPE_DIMENSIONS)
  end

  it "should render in portrait mode" do
    k = Kindler.new(orientation: 'portrait').process!(template_path: 'spec/templates/simple.haml',
                                                      image_output_path: 'portrait.png')

    expect(dimensions_for('portrait.png')).to eq(PORTRAIT_DIMENSIONS)
  end

  it "should render in landscape mode" do
    k = Kindler.new(orientation: 'landscape').process!(template_path:     'spec/templates/simple.haml',
                                                       image_output_path: 'landscape.png')

    expect(dimensions_for('landscape.png')).to eq(LANDSCAPE_DIMENSIONS)
  end
end
