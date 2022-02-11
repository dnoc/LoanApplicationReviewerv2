require 'bigdecimal/util'

class Loan
  SCHEMA_NAME = "LOAN".freeze

  attr_reader :application_id
  attr_accessor :principal_amount, :years, :rate, :monthly_payment

  def initialize(application_id:, principal_amount:, years:, rate:, monthly_payment:)
    @application_id = application_id
    @principal_amount = principal_amount
    @years = years
    @rate = rate
    @monthly_payment = monthly_payment
  end

  def self.build_from_string(string:)
    tokens = string.split(" ")
    self.new(
      application_id: tokens[1],
      principal_amount: BigDecimal(tokens[2]),
      years: tokens[3].to_i,
      rate: BigDecimal(tokens[4]),
      monthly_payment: BigDecimal(tokens[5])
    )
  end
end