# frozen_string_literal: true

class WorkbookForm
  def initialize(worksheet_name:,
                 header_row:,
                 header_offset:,
                 separators:,
                 word_separators:,
                 empty_label:)
    @worksheet_name = worksheet_name
    @header_row = header_row
    @header_offset = header_offset
    @separators = separators
    @word_separators = word_separators
    @empty_label = empty_label
  end

  attr_reader :worksheet_name, :header_row, :header_offset, :separators,
    :word_separators, :empty_label
end
