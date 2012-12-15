require "html_builder"
require "capybara"
require "nokogiri"

describe HTMLBuilder do
  let(:builder) { HTMLBuilder.new(Nokogiri::HTML::Builder.new) }

  it "renders a questionnaire as an html form" do
    builder.renderQuestionnaire
    html = Capybara.string(builder.print)

    html.should have_css("form")
  end

  it "can render questions inside of the form" do
    builder.renderQuestionnaire do
      builder.renderShortAnswerQuestion("id", "What is your name?")
    builder.renderMultipleChoiceQuestion("id", "What is your favorite color?", %w{red blue})
    end
    html = Capybara.string(builder.print)

    labels = html.all("form > fieldset > label").map(&:text)
    labels.should eq(["What is your name?", "What is your favorite color?"])
  end

  it "renders a short answer question as a text input" do
    builder.renderShortAnswerQuestion("id", "What is your name?")
    html = Capybara.string(builder.print)

    html.should have_field("What is your name?")
  end

  it "renders a multiple choice question as radio buttons" do
    builder.renderMultipleChoiceQuestion("id", "What is your favorite color?", %w{red blue})
    html = Capybara.string(builder.print)

    html.should have_field("red")
    html.should have_field("blue")
  end
end
