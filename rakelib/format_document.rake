require_relative 'lib/docx_formatter'

task :format_document, [:input_file_path] do |_, args|
  logger = Logger.new($stdout)
  logger.info('Transforming data')

  input_file_path = args[:input_file_path]

  if input_file_path.nil?
    logger.info('Please pass input_file to parameters')
    abort
  end

  form = WorkbookForm.new
  DocxFormatter.new(input_file_path, output_file_path).call
  logger.info('Transforming finished')
end
