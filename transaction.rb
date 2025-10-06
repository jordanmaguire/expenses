class Transaction
  attr_accessor :amount, :date, :narration

  def initialize(amount:, date:, narration:)
    self.amount = amount
    self.date = date
    self.narration = narration
  end

  def category
    # [
    #   [CARS, :cars],
    #   [FAST_FOOD, :fast_food],
    #   [GROCERIES, :groceries],
    #   [MEDICAL, :medical],
    #   [PETS, :pets],
    #   [SHOPPING, :shopping],
    # ].each do |string_fragments, category|
    #   # TODO: Highlight any expenses that are in multiple categories
    #   if string_fragments.any? { |string| narration.downcase.include?(string.downcase) }
    #     return category
    #   end
    # end

    Transaction::Category.all.find { _1.matches?(self) }
  end

  def to_s
    date_and_amount_fragment = "#{ date }: $#{ amount.to_f.abs }"

    if category
      "#{ date_and_amount_fragment } in #{ category }. (#{ narration })"
    else
      "#{ date_and_amount_fragment } uncategorised. (#{ narration })"
    end
  end
end
