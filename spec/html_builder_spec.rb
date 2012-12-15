require "html_builder"
require "capybara"
require "nokogiri"

describe HTMLBuilder do
  let(:nokogiri) { Nokogiri::HTML::Builder.new }
  let(:builder) { HTMLBuilder.new(nokogiri) }

  it "renders a short answer question as a text input" do
    builder.renderShortAnswerQuestion("id", "What is your name?")
    html = Capybara.string(nokogiri.to_html)

    html.should have_field("What is your name?")
  end

  it "renders a multiple choice question as radio buttons" do
    builder.renderMultipleChoiceQuestion("id", "What is your favorite color?", %w{red blue})
    html = Capybara.string(nokogiri.to_html)

    html.should have_field("red")
    html.should have_field("blue")
  end
end
