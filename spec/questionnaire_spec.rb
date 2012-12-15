require "questionnaire"
require "capybara"
require "nokogiri"

describe Questionnaire do
  let(:short_answer) { ShortAnswerQuestion.new("What is your name?") }
  let(:multiple_choice) { MultipleChoiceQuestion.new("What is your favorite color?", %w{red blue}) }
  let(:builder) { Nokogiri::HTML::Builder.new }

  it "displays every question" do
    questionnaire = Questionnaire.new([short_answer, multiple_choice])
    questionnaire.render(builder)
    view = Capybara.string(builder.to_html)

    labels = view.all("form > fieldset > label").map(&:text)
    labels.should eq(["What is your name?", "What is your favorite color?"])
  end

  it "displays a short answer question as a text input" do
    questionnaire = Questionnaire.new([short_answer])
    questionnaire.render(builder)
    view = Capybara.string(builder.to_html)

    view.should have_field("What is your name?")
  end

  it "displays a multiple choice questions as radio buttons" do
    questionnaire = Questionnaire.new([multiple_choice])
    questionnaire.render(builder)
    view = Capybara.string(builder.to_html)

    view.should have_field("red")
    view.should have_field("blue")
  end
end
