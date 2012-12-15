require "questionnaire"

describe Questionnaire do
  it "renders the questionnaire" do
    questionnaire = Questionnaire.new([])
    builder = mock

    builder.should_receive(:renderQuestionnaire)

    questionnaire.render(builder)
  end

  it "renders every question" do
    question0 = mock
    question1 = mock
    questionnaire = Questionnaire.new([question0, question1])

    builder = stub
    builder.stub(:renderQuestionnaire) { |&block| block.call }

    question0.should_receive(:render).with("question0", builder).ordered
    question1.should_receive(:render).with("question1", builder).ordered

    questionnaire.render(builder)
  end
end
