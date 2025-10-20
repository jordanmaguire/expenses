class AnnualSummary::SpreadsheetGenerator
  def initialize(annual_summary)
    @monthly_summaries = annual_summary.monthly_summaries
  end

  def to_spreadsheet
    p = Axlsx::Package.new
    wb = p.workbook

    @monthly_summaries.values.each do |monthly_summary|
      wb.add_worksheet(name: monthly_summary.month_name) do |sheet|
        monthly_summary.transactions_by_category.each do |category, transactions|
          sheet.add_row [category.name, transactions.sum { _1.amount.to_f}]
          sheet.add_row ["Date", "Amount", "Narration"]
          transactions.each do |transaction|
            sheet.add_row [
              transaction.date,
              transaction.amount,
              transaction.narration,
            ]
          end
          sheet.add_row []
        end
      end
    end

    p.serialize "spreadsheet/basic_example.xlsx"
  end
end
