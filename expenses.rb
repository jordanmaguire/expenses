# Run in IRB for quick debugging
# require_relative "expenses"

require 'byebug'
require 'csv'
require 'date'

class Expense
end

require_relative './expense/account'
require_relative './expense/transaction'
require_relative './expense/category'
require_relative './expense/transaction_category_prompt'
require_relative './monthly_summary'
require_relative './spreadsheet_generator'

Dir.glob(File.join(__dir__, "categories", "*.rb")).each do |file|
  require_relative file
end

monthly_summaries = MonthlySummary.for_current_year

# BSB Number,Account Number,Transaction Date,Narration,Cheque Number,Debit,Credit,Balance,Transaction Type
expense_accounts = [
  Expense::Account.new(monthly_summaries: monthly_summaries, file_path: "/workspaces/expenses/sample/credit_card.csv"),
  Expense::Account.new(monthly_summaries: monthly_summaries, file_path: "/workspaces/expenses/sample/recurring_expenses.csv"),
]

expense_accounts.each(&:extract_expenses)

monthly_summaries.values.reverse.each { _1.print_summary }

SpreadsheetGenerator.new(monthly_summaries.values).to_spreadsheet
