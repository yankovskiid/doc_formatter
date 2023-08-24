# frozen_string_literal: true

module DocFormatter
  class WorkbookForm < Struct.new(
    :worksheet_name,
    :header_row,
    :header_offset,
    :separators,
    :word_separators,
    :empty_label,
    keyword_init: true
  )
  end
end
