require "spec_helper"

RSpec.describe Application do
  describe "#credit_score" do
    let(:application) { described_class.new(id: "test") }

    let(:brent) { Borrower.new(application_id: application.id, name: "Brent", credit_score: 500) }
    let(:daphne) { Borrower.new(application_id: application.id, name: "Daphne", credit_score: 750) }
    let(:zardoz) { Borrower.new(application_id: application.id, name: "Zardoz", credit_score: 500) }

    describe "when one score is lower" do
      before { application.borrowers = [brent, daphne] }

      it "picks the lowest score" do
        expect(application.credit_score).to eq(brent.credit_score)
      end
    end

    describe "when the scores are equal" do
      before { application.borrowers = [brent, zardoz] }

      it "picks the equal lowest score" do
        expect(application.credit_score).to eq(brent.credit_score)
        expect(application.credit_score).to eq(zardoz.credit_score)
      end
    end
  end

  describe "#dti" do
    let(:application) { described_class.new(id: "test") }

    let(:income1) { Income.new(application_id: "test", name: "John", kind: "Salary", monthly_amount: BigDecimal("4021.29")) }
    let(:income2) { Income.new(application_id: "test", name: "Jane", kind: "Salary", monthly_amount: BigDecimal("4523.14")) }
    let(:income3) { Income.new(application_id: "test", name: "Jane", kind: "ChildSupport", monthly_amount: BigDecimal("203.14")) }

    let(:liability1) do
      Liability.new(
        application_id: "test",
        comma_separated_names: "John",
        kind: "CreditCard",
        monthly_payment: BigDecimal("35.14"),
        outstanding_balance: BigDecimal("1491.24")
      )
    end
    let(:liability2) do
      Liability.new(
        application_id: "test",
        comma_separated_names: "Jane",
        kind: "CreditCard",
        monthly_payment: BigDecimal("10.14"),
        outstanding_balance: BigDecimal("20.24")
      )
    end
    let(:liability3) do
      Liability.new(
        application_id: "test",
        comma_separated_names: "Jane,John",
        kind: "Mortgage",
        monthly_payment: BigDecimal("1230.41"),
        outstanding_balance: BigDecimal("235194.10")
      )
    end
    let(:loan1) do
      Loan.new(
        application_id: "test",
        principal_amount: BigDecimal("313000"),
        years: 15,
        rate: BigDecimal("2.5"),
        monthly_payment: BigDecimal("1420.20")
      )
    end
    let(:loan2) do
      Loan.new(
        application_id: "test",
        principal_amount: BigDecimal("145000"),
        years: 30,
        rate: BigDecimal("3.1"),
        monthly_payment: BigDecimal("810.20")
      )
    end

    describe "happy path" do
      before do
        application.incomes = [income1, income2, income3]
        application.liabilities = [liability1, liability2, liability3]
        application.loans = [loan1]
      end

      it "calculates dti" do
        expect(application.dti.truncate(5)).to eq(0.30702)
      end
    end

    describe "when there are no liabilities" do
      before do
        application.incomes = [income1, income2, income3]
        application.liabilities = []
        application.loans = [loan1]
      end

      it "calculates dti" do
        expect(application.dti.truncate(5)).to eq(0.16235)
      end
    end

    describe "when no liabilities are applicable" do
      before do
        application.incomes = [income1, income2, income3]
        application.liabilities = [liability2]
        application.loans = [loan1]
      end

      it "calculates dti" do
        expect(application.dti.truncate(5)).to eq(0.16235)
      end
    end

    describe "when there are multiple loans" do
      before do
        application.incomes = [income1, income2, income3]
        application.liabilities = [liability1, liability2, liability3]
        application.loans = [loan1, loan2]
      end

      it "calculates dti" do
        expect(application.dti.truncate(5)).to eq(0.39964)
      end
    end

    describe "when there is one income" do
      before do
        application.incomes = [income1]
        application.liabilities = [liability1, liability2, liability3]
        application.loans = [loan1]
      end

      it "calculates dti" do
        expect(application.dti.truncate(5)).to eq(0.66788)
      end
    end
  end
end