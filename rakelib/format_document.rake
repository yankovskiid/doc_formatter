#require_relative '../lib/docx_formatter'
#require_relative '../lib/data_processor'
require_relative '../lib/doc_formatter/forms/workbook_form'
require_relative '../lib/doc_formatter/data_processor'


task :format_document, [:input_file_path] => :environment do |_, args|
  logger = Logger.new($stdout)
  logger.info('Transforming data')

  input_file_path = args[:input_file_path]

  if input_file_path.nil?
    logger.info('Please pass input_file to parameters')
    abort
  end

  form = WorkbookForm.new
  DataProcessor.new(input_file_path, output_file_path).call

  logger.info('Transforming finished')
end

task :format_test, [:input_file_path, :out_file_path] do |_, args|
  logger = Logger.new($stdout)
  logger.info('Trasforming data')

  input_file_path = args[:input_file_path]
  out_file_path = args[:out_file_path]
  form = DocFormatter::WorkbookForm.new(
    worksheet_name: 'Station Name',
    header_row: ['Plan', 'Zone', 'Zone (Area identified)', 'Details of zone', 'Guidance Notes'
    ],
    header_offset: 2,
    separators: /(?:\(.*?\)|[^,.])+/,
    word_separators: %w[and for ATG SCP DCS StationEntrance],
    empty_label: 'NA')

  if input_file_path.nil?
    logger.info('Please pass input_file to parameters')
    abort
  end

  DocFormatter::DataProcessor.new(input_file_path, form).call
  logger.info('Transforming finished')
end
