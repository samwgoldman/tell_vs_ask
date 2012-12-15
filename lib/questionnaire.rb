ShortAnswerQuestion = Struct.new(:prompt) do
  def render(id, builder)
    builder.renderShortAnswerQuestion(id, prompt)
  end
end

MultipleChoiceQuestion = Struct.new(:prompt, :choices) do
  def render(id, builder)
    builder.renderMultipleChoiceQuestion(id, prompt, choices)
  end
end

class Questionnaire
  def initialize(questions)
    @questions = questions
  end

  def render(builder)
    @questions.each_with_index do |question, index|
      question_id = "question#{index}"
      question.render(question_id, builder)
    end
  end
end
