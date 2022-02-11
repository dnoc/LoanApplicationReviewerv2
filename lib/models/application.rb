class Application
  SCHEMA_NAME = "APPLICATION".freeze
  attr_reader :id
  attr_accessor :borrowers, :incomes, :loans, :liabilities

  def initialize(id:)
    @id = id
    @borrowers = []
    @incomes = []
    @loans = []
    @liabilities = []
  end

  def self.build_from_string(string:)
    tokens = string.split(" ")
    self.new(id: tokens[1])
  end

  def credit_score
    @borrowers.map { |b| b.credit_score }.min
  end

  def dti
    total_loan_payments = @loans.sum { |loan| loan.monthly_payment }
    applicable_liabilities = @liabilities.filter { |l| l.applicable_to_dti? }

    total_applicable_liability = total_loan_payments + applicable_liabilities.sum { |l| l.monthly_payment }

    total_applicable_liability / @incomes.sum { |i| i.monthly_amount }
  end
end