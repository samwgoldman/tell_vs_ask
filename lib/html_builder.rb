class HTMLBuilder
  def initialize(builder)
    @builder = builder
  end

  def renderQuestionnaire(&block)
    @builder.form do |without_scope_stealing|
      yield if block_given?
    end
  end

  def renderShortAnswerQuestion(id, prompt)
    @builder.fieldset do |html|
      html.label(:for => id) { html.text prompt }
      html.input(:type => "text", :id => id, :name => id)
    end
  end

  def renderMultipleChoiceQuestion(id, prompt, choices)
    @builder.fieldset do |html|
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

  def print
    @builder.to_html
  end
end
