require 'bigdecimal/util'

class Income
  SCHEMA_NAME = "INCOME".freeze

  attr_reader :application_id
  attr_accessor :name, :kind, :monthly_amount

  def initialize(application_id:, name:, kind:, monthly_amount:)
    @application_id = application_id
    @name = name
    @kind = kind
    @monthly_amount = monthly_amount
  end

  def self.build_from_string(string:)
    tokens = string.split(" ")
    self.new(
      application_id: tokens[1],
      name: tokens[2],
      kind: tokens[3],
      monthly_amount: BigDecimal(tokens[4])
    )
  end
end