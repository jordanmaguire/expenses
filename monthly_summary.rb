class MonthlySummary
  # An integer from a Date object so we can easily reference it. 1 is January
  attr_accessor :month, :year
  attr_accessor :transactions

  def self.for_current_year
    hash = {}

    (1..12).each { hash[_1] = new(month: _1, year: Date.today.year) }

    hash
  end

  def initialize(month:, year:)
    @month = month
    @year = year
    @transactions = []
  end

  def month_name
    Date::MONTHNAMES[@month]
  end

  def print_summary
    puts "#{ month_name }: "
    transactions_by_category.each do |category, transactions|
      puts "- #{ category.name }: #{ transactions.count }"
    end
    puts
  end

  def transactions_by_category
    hash = {}

    Expense::Category.all.each do |category|
      hash[category] = @transactions.select { _1.category == category }
    end

    hash
  end
end
