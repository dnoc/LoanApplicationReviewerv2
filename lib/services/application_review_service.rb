require_relative 'application_object_factory'
Dir["#{File.dirname(__FILE__)}/../models/*.rb"].each { |file| require file }

class ApplicationReviewService
  def initialize
    @applications = []
    @decisions = []
  end

  def review(file:)
    _read_file(file)

    _make_decisions
    _print_decisions
    
    @decisions
  end

  private

  def _read_file(file)
    file.readlines.each do |line|
      unless (line.empty?)
        object = ApplicationObjectFactory.from_string(string: line)
        _save_object(object)
      end
    end
  end

  def _save_object(object)
    case
    when object.is_a?(Application)
      @applications << object
    when object.is_a?(Borrower)
      @applications.last.borrowers << object
    when object.is_a?(Income)
      @applications.last.incomes << object
    when object.is_a?(Liability)
      @applications.last.liabilities << object
    when object.is_a?(Loan)
      @applications.last.loans << object
    end
  end

  def _make_decisions
    @applications.each do |application|
      @decisions << ApplicationDecision.new(application_id: application.id, dti: application.dti, credit_score: application.credit_score)
    end
  end

  def _print_decisions
    approval_count = @decisions.select { |d| d.approved? }.length
    approval_rate_string = sprintf("%0.01f", (approval_count.to_f / @decisions.length) * 100)

    puts ""
    puts "Summary: #{approval_count} application approved, #{@decisions.length} applications received, #{approval_rate_string}% approval rate"
    puts ""

    @decisions.each do |d|
      puts "#{d.application_id}: #{d.approved? ? 'approved' : 'denied'}, DTI: #{d.dti.truncate(3).to_s('F')}, Credit Score: #{d.credit_score}"
    end
  end
end