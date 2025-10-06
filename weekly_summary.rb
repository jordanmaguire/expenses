class WeeklySummary
  attr_accessor :start_date, :end_date
  attr_accessor :transactions

  def self.for_current_year
    (1..52).map { new(cweek: _1, year: Date.today.year) }
  end

  def initialize(cweek:, year:)
    @cweek = cweek
    @year = year
    @start_date = start_date
    @end_date = end_date
    @transactions = []
  end

  def categorized_transactions
    @transactions.select { !_1.category.nil? }
  end

  def uncategorized_transactions
    @transactions.select { _1.category.nil? }
  end

  def start_date
    if @cweek == 1
      year = @year - 1
      cweek = 52
    else
      year = @year
      cweek = @cweek - 1
    end
    saturday = Date.commercial(year, cweek, 6)
  end

  # I pay expenses on a Friday, so this will be last Saturday to Friday.
  def end_date
    Date.commercial(@year, @cweek, 5)
  end

  def includes?(date)
    date >= start_date && date <= end_date
  end
end
