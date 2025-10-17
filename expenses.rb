require 'byebug'
require 'csv'
require 'date'

require_relative './transaction'
require_relative './category'
require_relative './weekly_summary'

Dir.glob(File.join(__dir__, "categories", "*.rb")).each do |file|
  require_relative file
end

# weekly_summaries = WeeklySummary.for_current_year

# BSB Number,Account Number,Transaction Date,Narration,Cheque Number,Debit,Credit,Balance,Transaction Type
test_file_path = "/workspaces/expenses/sample/Transactions_17_10_2025.csv"
transactions = []
CSV.parse(File.read(test_file_path), headers: true) do |csv|
  next if csv["Narration"].include?("AUTHORISATION ONLY")
  # I pay amount into this account to pay off debts - do not include these transactions
  next if csv["Debit"] == nil

  transaction_date = Date.parse(csv["Transaction Date"])
  # weekly_summary = weekly_summaries.find { _1.includes?(transaction_date) }
  # weekly_summary.transactions << Transaction.new(
  #   amount: csv["Debit"],
  #   date: transaction_date,
  #   narration: csv["Narration"],
  # )

  transactions << Transaction.new(
    amount: csv["Debit"],
    date: transaction_date,
    narration: csv["Narration"],
  )
end

# ws = weekly_summaries.select { _1.transactions.count > 0 }
# puts ws[3].uncategorized_transactions
