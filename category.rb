class Transaction::Category
  def self.all
    @all ||= []
  end

  def self.add(name:, string_fragments:)
    all << new(
      name: name,
      string_fragments: string_fragments,
    )
  end

  attr_accessor :name, :string_fragments

  def initialize(name:, string_fragments:)
    @name = name
    @string_fragments = string_fragments
  end

  def matches?(transaction)
    string_fragments.any? { |string| transaction.narration.downcase.include?(string.downcase) }
  end

  def to_s
    name
  end
end
