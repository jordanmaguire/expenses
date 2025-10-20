class AnnualSummary
  attr_reader :monthly_summaries

  def initialize(year: Time.now.year, savings_account_file:, expense_account_files:)
    @monthly_summaries = MonthlySummary.for_current_year

    @expense_account_files = expense_account_files
    @expense_accounts = @expense_account_files.map { Expense::Account.new(annual_summary: self, file_path: _1) }
    @expense_accounts.each(&:extract_expenses)

    @savings_account_file = savings_account_file
    @year = year
  end

  def add_transaction(transaction)
    @monthly_summaries[transaction.date.month].transactions << transaction
  end

  def to_spreadsheet
    AnnualSummary::SpreadsheetGenerator.new(self).to_spreadsheet
  end
end

require_relative "./annual_summary/spreadsheet_generator"
