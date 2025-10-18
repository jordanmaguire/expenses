class Transaction::Category
  def self.all
    @all ||= []
  end

  def self.add(name:, filename:)
    all << new(
      name: name,
      filename: filename
    )
  end

  attr_accessor :name, :filename

  def initialize(name:, filename:)
    @filename = filename
    @name = name
  end

  def matches?(transaction)
    string_fragments.any? { |string| transaction.narration.downcase.include?(string.downcase) }
  end

  def string_fragments
    @string_fragments ||= File.readlines(file_path).map(&:strip)
  end

  def add_string_fragment(string_fragment)
    # Ensure the values are alphabetical for readability - use downcase because upper/lower do not have the same
    # precedence.
    @string_fragments = (string_fragments + [string_fragment]).sort_by(&:downcase)

    # Write the sorted values to the file.
    File.open(file_path, mode: "w") { |file| file.write(@string_fragments.join("\n")) }
  end

  def to_s
    name
  end

  private def file_path
    "categories/#{ filename }"
  end
end

[
  "Cars",
  "Fast Food",
  "Groceries",
  "Holidays",
  "Home Improvement",
  "Leisure",
  "Medical",
  "Pets",
  "Recurring",
  "Shopping",
].each do |category_name|
  Transaction::Category.add(
    name: category_name,
    filename: category_name.gsub(" ", "_"),
  )
end
