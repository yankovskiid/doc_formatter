# frozen_string_literal: true

require "axlsx"
#require "active_support"
require "active_support/all"
require "doc_formatter/docx_file_parser"
require "doc_formatter/excel_writer"

module DocFormatter
  class DataProcessor
    DOCX_FILE_EXTENSION_REGEX = /(\.docx)/
    XLSX_FILE_EXTENSION = ".xlsx"

    def initialize(input_dir_path, form)
      @input_dir_path = input_dir_path
      @form = form
    end

    def call
      input_filenames = Dir[input_dir_path]
      input_filenames.each do |file|
        header, table_data = parse_doc_file(file)

        package = Axlsx::Package.new
        write_workbook(package, header, table_data)

        filename = file.gsub(DOCX_FILE_EXTENSION_REGEX, XLSX_FILE_EXTENSION)
        #package.serialize(filename)
        package.serialize(['./tmp/rm-central-test/test', XLSX_FILE_EXTENSION].join)
      end
    end

    private

    attr_reader :input_dir_path, :form

    def parse_doc_file(file)
      DocxFileParser.new(file).call
    end

    def write_workbook(package, header, table_data)
      ExcelWriter.new(package, header:,
                               table_data:,
                               form:).call
    end
  end
end
