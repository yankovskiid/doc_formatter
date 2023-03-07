# frozen_string_literal: true

require_relative "doc_formatter/version"
require "axlsx"
require "docx"
require "active_support"
require "active_support/all"

module DocFormatter
  class Error < StandardError; end
end
