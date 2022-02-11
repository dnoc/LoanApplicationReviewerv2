require 'spec_helper'

RSpec.describe ApplicationObjectFactory do
  describe "#from_string" do
    subject { described_class.from_string(string: input) }

    describe("with application input string") do
      let(:input) { "APPLICATION A1" }
      it { is_expected.to be_a Application }
    end

    describe("with loan input string") do
      let(:input) { "LOAN A1 313000 15 2.5 1420.20" }
      it { is_expected.to be_a Loan }
    end

    describe("with borrower input string") do
      let(:input) { "BORROWER A1 John 720" }
      it { is_expected.to be_a Borrower }
    end

    describe("with coborrower input string") do
      let(:input) { "COBORROWER A1 Jane 750" }
      it { is_expected.to be_a Borrower }
    end

    describe("with liability input string") do
      let(:input) { "LIABILITY A1 John CreditCard 35.14 1491.24" }
      it { is_expected.to be_a Liability }
    end

    describe("with income input string") do
      let(:input) { "INCOME A1 John Salary 4021.29" }
      it { is_expected.to be_a Income }
    end
  end
end