# Run in IRB for quick debugging
# require_relative "expenses"

require 'byebug'
require 'csv'
require 'date'

class Expense
end

require_relative './annual_summary'
require_relative './expense/account'
require_relative './expense/transaction'
require_relative './expense/category'
require_relative './expense/transaction_category_prompt'
require_relative './monthly_summary'

# BSB Number,Account Number,Transaction Date,Narration,Cheque Number,Debit,Credit,Balance,Transaction Type
annual_summary = AnnualSummary.new(
  savings_account_file: "/workspaces/expenses/sample/savings.csv",
  expense_account_files: [
    "/workspaces/expenses/sample/credit_card.csv",
    "/workspaces/expenses/sample/recurring_expenses.csv",
  ]
)
annual_summary.to_spreadsheet
