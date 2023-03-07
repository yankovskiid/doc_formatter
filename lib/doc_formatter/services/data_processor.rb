# frozen_string_literal: true

class DataProcessor
  DOCX_FILE_EXTENSION_REGEX = /(\.docx)/
  XLSX_FILE_EXTENSION = ".xlsx"

  def initialize(input_dir_path, _form)
    @input_dir_path = input_dir_path
  end

  def call
    input_filenames = Dir[input_dir_path]
    input_filenames.each do |file|
      header, table_data = parse_doc_file(file)

      package = Axlsx::Package.new
      write_workbook(package, header, table_data)

      filename = file.gsub(DOCX_FILE_EXTENSION_REGEX, XLSX_FILE_EXTENSION)
      package.serialize(filename)
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
