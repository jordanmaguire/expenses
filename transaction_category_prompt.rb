class TransactionCategoryPrompt
  def initialize(categories: Transaction::Category.all, transaction:)
    @categories = categories
    @transaction = transaction
  end

  def show_prompt
    puts
    puts @transaction.narration
    puts
    @categories.each.with_index do |category, index|
      position = positions[index]
      puts "#{ position }. #{ category.name }"
    end
    puts

    selection = gets.strip.to_i
    # #to_i will return 0 when the value can't be coerced into an integer.
    if selection == 0
      puts "Skipping category selection."
    elsif (category_index = positions.index(selection)) && (category = @categories[category_index])
      category.add_string_fragment(@transaction.narration)
    else
      puts "Invalid selection"
    end
  end

  # The prompts become 1..4, 11..14, 21..24, 31..34
  # It's easier to type 11 then it is to get to 6.
  private def positions
    4.times.flat_map { ((_1*10+1)..(_1*10+4)).to_a }
  end
end
