class Expense::Account
  def initialize(annual_summary:, file_path:)
    @annual_summary = annual_summary
    @file_path = file_path
  end

  def extract_expenses
    CSV.parse(File.read(@file_path), headers: true) do |csv|
      # This will be on credit cards for pending transactions
      next if csv["Narration"].include?("AUTHORISATION ONLY")
      # I pay amount into these accounts to pay off debts - do not include these transactions
      next if csv["Debit"] == nil

      transaction_date = Date.parse(csv["Transaction Date"])
      transaction = Expense::Transaction.new(
        amount: csv["Debit"],
        date: transaction_date,
        narration: csv["Narration"],
      )

      if transaction.category.nil?
        Expense::TransactionCategoryPrompt.new(transaction: transaction).show_prompt
      end

      @annual_summary.add_transaction(transaction)
    end
  end
end
