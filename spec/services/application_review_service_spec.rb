require "spec_helper"

RSpec.describe ApplicationReviewService do
  describe "#review" do
    let(:result) { described_class.new.review(file: file) }

    let(:file) { File.new(path, "r")}
    let(:path) { "#{File.dirname(__FILE__)}/../../input.txt" }

    let(:expected_dti_1) { BigDecimal("2685.75") / BigDecimal("8747.57") }
    let(:expected_dti_2) { BigDecimal("2126.3") / 3900 }

    it "makes application decisions", :aggregate_failures do
      expect(result.length).to eq(2)
      expect(result[0]).to be_a(ApplicationDecision)
      expect(result[0]).to have_attributes(application_id: "A1", dti: expected_dti_1, credit_score: 720, approved: true)

      expect(result[1]).to be_a(ApplicationDecision)
      expect(result[1]).to have_attributes(application_id: "A2", dti: expected_dti_2, credit_score: 621, approved: false)
    end
  end
end