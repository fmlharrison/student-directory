#let's put all the students into an array.
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffery Baratheon",
  "Norman Bates"
]
#we print the students

def print_header
  puts "The students of Villians Academy"
  puts "--------------"
end

def print(names)
  names.each do |names|
    puts names
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end
# nothing happens until will call the methods
print_header
print(students)
print_footer(students)
