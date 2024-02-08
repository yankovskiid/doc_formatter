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

    def initialize(input_dir_path, form, out_file_path)
      @input_dir_path = input_dir_path
      @form = form
      @out_file_path = out_file_path
    end

    def call
      input_filenames = Dir[input_dir_path]
      input_filenames.each do |file|
        header, table_data = parse_doc_file(file)

        package = Axlsx::Package.new
        write_workbook(package, header, table_data)

        filename =  File.basename(file, '.*')
        #filename = file.gsub(DOCX_FILE_EXTENSION_REGEX, XLSX_FILE_EXTENSION)
        package.serialize([out_file_path, filename, XLSX_FILE_EXTENSION].join)
        #package.serialize(filename)
      end
    end

    private

    attr_reader :input_dir_path, :form, :out_file_path, :out_file_path

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
