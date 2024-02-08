# frozen_string_literal: true

module DocFormatter
  class ExcelWriter
    NUMERIC_CELL_REGEX = /\A\d+\z/
    STRING_CELL_REGEX = /\w+/
    SEPARATOR = " "
    MAGIC_NUMBER_MINUS_ONE = -1
    MAGIC_NUMBER_ONE = 1
    MAGIC_NUMBER_TWO = 2

    def initialize(package, header:, table_data:, form:)
      @package = package
      @header = header
      @table_data = table_data
      @form = form
    end

    def call
      package.workbook.add_worksheet(name: form.worksheet_name) do |sheet|
        sheet.add_row(transform_header)
        sheet.add_row(form.header_row)

        transform_data(table_data).each do |row|
          sheet.add_row(row)
        end
      end
    end

    private

    attr_reader :package, :header, :table_data, :form

    def transform_header
      header.last.each_slice(MAGIC_NUMBER_TWO).map do |header_fields|
        header_fields.join(SEPARATOR)
      end
    end

    def transform_data(table)
      table.drop(form.header_offset).map do |row|
        row.last.scan(form.separators).filter_map do |question|
          next if question.squish.strip.empty?
          next if question.strip == 'N/A'
          next unless NUMERIC_CELL_REGEX.match(question.strip).nil?

          row[MAGIC_NUMBER_TWO] = capitalize_text(row[MAGIC_NUMBER_TWO])
          row[...MAGIC_NUMBER_MINUS_ONE].push(question.strip, form.empty_label)
        end
      end.flatten(MAGIC_NUMBER_ONE)
    end

    def capitalize_text(text)
      text
        .gsub(' / ','/')
        .gsub('&', ' & ')
        .squish
        .gsub(STRING_CELL_REGEX) do |match|
          form.word_separators.include?(match) ? match : match.capitalize
        end
    end
  end
end
