require "spec_helper"

RSpec.describe Liability do
  describe "#applicable_to_dti?" do
    subject { liability.applicable_to_dti? }

    let(:liability) do
      described_class.new(
        application_id: 1,
        comma_separated_names: "Brent,Daphne",
        kind: "CreditCard",
        monthly_payment: monthly_payment,
        outstanding_balance: outstanding_balance
      )
    end

    let(:monthly_payment) { BigDecimal("35.14") }
    let(:outstanding_balance) { BigDecimal("1491.24") }

    describe "with greater than 10 payments left" do
      it { is_expected.to be(true) }
    end

    describe "with fewer than 10 payments left" do
      let(:monthly_payment) { BigDecimal("201.58") }

      it { is_expected.to be(false) }
    end

    describe "with exactly 10 payments left" do
      let(:monthly_payment) { BigDecimal("1049.12") }
      let(:outstanding_balance) { BigDecimal("10491.20") }

      it { is_expected.to be(false) }
    end
  end
end