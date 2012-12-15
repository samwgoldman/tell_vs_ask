class PDFBuilder
  def initialize(builder)
    @builder = builder
  end

  def renderShortAnswerQuestion(id, prompt)
    @builder.text prompt
  end

  def renderMultipleChoiceQuestion(id, prompt, choices)
    @builder.text prompt
    choices.each do |choice|
      @builder.text choice
    end
  end
end
