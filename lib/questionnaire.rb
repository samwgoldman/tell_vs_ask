ShortAnswerQuestion = Struct.new(:prompt)
MultipleChoiceQuestion = Struct.new(:prompt, :choices)

class Questionnaire
  def initialize(questions)
    @questions = questions
  end

  def render(builder)
    builder.form do |html|
      @questions.each_with_index do |question, index|
        question_id = "question#{index}"
        html.fieldset {
          case question
          when ShortAnswerQuestion
            html.label(:for => question_id) { html.text question.prompt }
            html.input(:type => "text", :id => question_id, :name => question_id)
          when MultipleChoiceQuestion
            html.label { html.text question.prompt }
            html.ul {
              question.choices.each do |choice|
                choice_id = "#{question_id}_#{choice}"
                html.li {
                  html.label(:for => choice_id) { html.text choice }
                  html.input(:type => "radio", :id => choice_id, :name => choice_id)
                }
              end
            }
          end
        }
      end
    end
  end
end
