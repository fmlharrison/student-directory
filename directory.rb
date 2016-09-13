def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit enter twice."
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name variable is not empty, repeat the following code.
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} great students."
    #now we get another name from the user
    name = gets.chomp
  end
  #return the array of students
  students
end
#let's put all the students into an array.
=begin
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffery Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
#we print the students
=end

def print_header
  puts "The students of Villians Academy"
  puts "--------------"
end

def print(students)
  students.each do |students|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end
# nothing happens until will call the methods
student = input_students
print_header
print(students)
print_footer(students)
