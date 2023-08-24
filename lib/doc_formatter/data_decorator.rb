# frozen_string_literal: true

module DocFormatter
  class DataDecorator
    def initialize(table)
      @table = table
    end

    def call
    end

    private

    attr_reader :table

    def transform_data(table)
      table.drop(form.header_offset).map do |row|
        row.last.scan(form.separators).filter_map do |question|
          next if question.strip.empty?
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
