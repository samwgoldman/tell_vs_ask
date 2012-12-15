require "pdf_builder"
require "prawn"
require "pdf/inspector"

describe PDFBuilder do
  let(:prawn) { Prawn::Document.new }
  let(:builder) { PDFBuilder.new(prawn) }

  it "renders a short answer question as text" do
    builder.renderShortAnswerQuestion("id", "What is your name?")

    pdf = PDF::Inspector::Page.analyze(prawn.render)
    pdf.show_text.should include("What is your name?")
  end

  it "renders a multiple choice question" do
    builder.renderMultipleChoiceQuestion("id", "What is your favorite color?", %w{red blue})

    pdf = PDF::Inspector::Page.analyze(prawn.render)
    pdf.show_text.should include("What is your favorite color?")
    pdf.show_text.should include("red")
    pdf.show_text.should include("blue")
  end
end
