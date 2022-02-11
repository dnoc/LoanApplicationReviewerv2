require 'bigdecimal/util'

class Liability
  SCHEMA_NAME = "LIABILITY".freeze
  MIN_APPLICABLE_PAYMENTS = 10.freeze

  attr_reader :application_id
  attr_accessor :comma_separated_names, :kind, :monthly_payment, :outstanding_balance

  def initialize(application_id:, comma_separated_names:, kind:, monthly_payment:, outstanding_balance:)
    @application_id = application_id
    @comma_separated_names = comma_separated_names
    @kind = kind
    @monthly_payment = monthly_payment
    @outstanding_balance = outstanding_balance
  end

  def self.build_from_string(string:)
    tokens = string.split(" ")
    self.new(
      application_id: tokens[1],
      comma_separated_names: tokens[2],
      kind: tokens[3],
      monthly_payment: BigDecimal(tokens[4]),
      outstanding_balance: BigDecimal(tokens[5])
    )
  end

  def applicable_to_dti?
    outstanding_balance / monthly_payment > MIN_APPLICABLE_PAYMENTS
  end
end