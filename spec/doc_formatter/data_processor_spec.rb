# frozen_string_literal: true

require 'spec_helper'
RSpec.describe ::DocFormatter::DataProcessor do
  subject(:data_processor) { described_class.new(path, form).call }

  describe 'call' do
    it 'creates xlsx from docx' do
      expect { data_processor }.to change()
    end

    xit 'calls DocxFileParser' do
    end

    xit 'calls ExcelWriter' do
    end
  end
end
