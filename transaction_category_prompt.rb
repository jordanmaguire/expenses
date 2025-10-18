class TransactionCategoryPrompt
  def initialize(categories: Transaction::Category.all, transaction:)
    @categories = categories
    @transaction = transaction
  end

  def show_prompt
    puts
    puts @transaction.narration
    puts
    @categories.each.with_index(1) do |category, position|
      puts "#{ position }. #{ category.name }"
    end
    puts

    selection = gets.strip.to_i
    if selection == 0
      puts "Skipping category selection."
    elsif (category = @categories[selection - 1])
      category.add_string_fragment(@transaction.narration)
    else
      puts "Invalid selection"
    end
  end
end
