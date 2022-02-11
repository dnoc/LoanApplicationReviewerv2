require 'bigdecimal/util'

class ApplicationDecision
  attr_reader :application_id, :approved, :dti, :credit_score

  def initialize(application_id:, dti:, credit_score:)
    @application_id = application_id
    @dti = dti
    @credit_score = credit_score
    @approved = _is_approved?
  end

  def approved?
    approved
  end

  private

  def _is_approved?
    @dti < BigDecimal("0.5") && @credit_score > 620
  end
end