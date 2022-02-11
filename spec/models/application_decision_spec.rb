require "spec_helper"

RSpec.describe ApplicationDecision do
  describe "#approved?" do
    subject { described_class.new(application_id: "test", dti: dti, credit_score: credit_score).approved? }

    let(:dti) { BigDecimal("0.1") }
    let(:credit_score) { 700 }

    describe "with dti less than 0.5 and credit score greater than 620" do
      it { is_expected.to be(true) }
    end

    describe "with dti greater than 0.5" do
      let(:dti) { BigDecimal("0.6") }

      it { is_expected.to be(false) }
    end

    describe "with credit score less than 620" do
      let(:credit_score) { 500 }

      it { is_expected.to be(false) }
    end

    describe "with dti equal to 0.5" do
      let(:dti) { BigDecimal("0.5") }

      it { is_expected.to be(false) }
    end

    describe "with credit score equal to 620" do
      let(:credit_score) { 620 }

      it { is_expected.to be(false) }
    end
  end
end