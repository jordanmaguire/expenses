# Run in IRB for quick debugging
# require_relative "expenses"

require 'byebug'
require 'csv'
require 'date'

class Expense
end

require_relative './expense/transaction'
require_relative './expense/category'
require_relative './expense/transaction_category_prompt'
require_relative './monthly_summary'

Dir.glob(File.join(__dir__, "categories", "*.rb")).each do |file|
  require_relative file
end

monthly_summaries = MonthlySummary.for_current_year

# BSB Number,Account Number,Transaction Date,Narration,Cheque Number,Debit,Credit,Balance,Transaction Type
test_file_path = "/workspaces/expenses/sample/credit_card.csv"
transactions = []
CSV.parse(File.read(test_file_path), headers: true) do |csv|
  next if csv["Narration"].include?("AUTHORISATION ONLY")
  # I pay amount into this account to pay off debts - do not include these transactions
  next if csv["Debit"] == nil

  transaction_date = Date.parse(csv["Transaction Date"])

  monthly_summaries[transaction_date.month].transactions << Expense::Transaction.new(
    amount: csv["Debit"],
    date: transaction_date,
    narration: csv["Narration"],
  )
end

monthly_summaries.values.reverse.each { _1.print_summary }

# puts "#{ transactions.select(&:category).count } Transactions with a category"
# puts "#{ transactions.reject(&:category).count } Transactions without a category"

# transactions.reject(&:category).each do |transaction|
#   # The transaction may be able to be categories based on a selection earlier. So we attempt to re-categorise first
#   # and only prompt to choose a category if it still can't be found.
#   if transaction.category.nil?
#     Expense::TransactionCategoryPrompt.new(transaction: transaction).show_prompt
#   end
# end
