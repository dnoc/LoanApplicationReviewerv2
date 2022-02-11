require './lib/services/application_review_service.rb'

if ARGV.length != 1
  puts "Error: please give me exactly one filename as input"
  return;
end

if File.exist?(ARGV[0])
  ApplicationReviewService.new.review(file: File.new(ARGV[0], "r"))
else
  puts "Error: file #{ARGV[0]} doesn't exist"
end
