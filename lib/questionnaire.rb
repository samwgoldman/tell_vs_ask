ShortAnswerQuestion = Struct.new(:prompt) do
  def render(id, builder)
    builder.fieldset do |html|
      html.label(:for => id) { html.text prompt }
      html.input(:type => "text", :id => id, :name => id)
    end
  end
end

MultipleChoiceQuestion = Struct.new(:prompt, :choices) do
  def render(id, builder)
    builder.fieldset do |html|
      html.label { html.text prompt }
      html.ul {
        choices.each do |choice|
          choice_id = "#{id}_#{choice}"
          html.li {
            html.label(:for => choice_id) { html.text choice }
            html.input(:type => "radio", :id => choice_id, :name => choice_id)
          }
        end
      }
    end
  end
end

class Questionnaire
  def initialize(questions)
    @questions = questions
  end

  def render(builder)
    builder.form do |html|
      @questions.each_with_index do |question, index|
        question_id = "question#{index}"
        question.render(question_id, html)
      end
    end
  end
end
