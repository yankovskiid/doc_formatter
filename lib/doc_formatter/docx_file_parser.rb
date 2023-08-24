# frozen_string_literal: true

require "docx"

module DocFormatter
  class DocxFileParser
    def initialize(file)
      @file = file
    end

    def call
      ::Docx::Document.open(file).tables.map do |table|
        table.rows.map do |row|
          row.cells.map(&:text)
        end
      end
    end

    private

    attr_reader :file
  end
end
