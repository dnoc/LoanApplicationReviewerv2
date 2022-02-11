class Borrower
  SCHEMA_NAME = "BORROWER".freeze
  COBORROWER_SCHEMA_NAME = "COBORROWER".freeze

  attr_reader :application_id
  attr_accessor :name, :credit_score

  def initialize(application_id:, name:, credit_score:)
    @application_id = application_id
    @name = name
    @credit_score = credit_score
  end

  def self.build_from_string(string:)
    tokens = string.split(" ")
    self.new(
      application_id: tokens[1],
      name: tokens[2],
      credit_score: tokens[3].to_i
    )
  end
end