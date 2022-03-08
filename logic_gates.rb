require 'pry-byebug'

def input_checker(array)
  array.all? { |item| item.is_a?(TrueClass) || item.is_a?(FalseClass) }
end

def and_method(*booleans)
  booleans.flatten!
  return puts 'Invalid input' unless input_checker(booleans)

  booleans.all?
end

def or_method(*booleans)
  booleans.flatten!
  return 'Invalid input' unless input_checker(booleans)
  
  booleans.any?
end

def not_method(boolean)
  return 'Invalid input' unless input_checker([boolean])

  boolean ? false : true
end

def nand_method(*booleans)
  not_method(and_method(booleans))
end

def nor_method(*booleans)
  not_method(or_method(booleans))
end

def xor_method(*booleans)
  booleans.flatten!
  return 'Invalid input' unless input_checker(booleans)
  return booleans.first if booleans.length == 1

  truthiness = not_method(booleans[0] == booleans[1])
  2.times { booleans.shift }
  booleans.unshift(truthiness)
  xor_method(booleans)
end

def method_getter
  prompt =
  <<~EOS
  Choose what type of logic gate you would like.
  A = AND
  O = OR
  N = NOT
  NA = NAND
  NO = NOR
  X = XOR
  EOS

  puts prompt
  allowed = %w[a o n na no x]
  chosen_gate = gets.chomp.downcase
  allowed.include?(chosen_gate) ? chosen_gate : 'Invalid input'
end

def value_getter
  puts 'What values would you like to test? Enter T for True and F for False'
  puts "\nAll gates take unlimited values, except for NOT (which only takes one)"
  puts "\nYou may type your values out in one line." 

  values = gets.chomp.downcase
  values = values.split('')
  values.each { |value| values.delete(value) unless ('a'..'z').to_a.include?(value) }
  return "Invalid input or inputs" unless values.all? { |value| value == 't' || value == 'f' }

  values.map { |value| value == 't' ? true : false }
end

def combiner
  values = value_getter

  result = case method_getter
  when 'a'
    and_method(values)
  when 'o'
    or_method(values)
  when 'n'
    not_method(values)
  when 'na'
    nand_method(values)
  when 'no'
    nor_method(values)
  when 'x'
    xor_method(values)
  end

  puts result
end

combiner
