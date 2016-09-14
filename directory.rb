def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask th use what to do
    puts "1. Input the student"
    puts "2. Show the studetns"
    puts "9. Exit"
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
      when "1"
        students = input_students
      when "2"
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit # this will terminate the program
      else
        puts "I don't know what you meant, try again"
    end

    # 4. repeat from step 1
  end
end



def input_students
  students = []
  puts "Please enter the names of the students."
  name = gets.chomp
  puts "Please enter their cohort month. To finish, just hit enter twice."
  cohort = gets.chomp

  #while the name variable is not empty, repeat the following code.
  while !name.empty? do
    cohort = "september" if cohort.empty?
    #add the student hash to the array
    students << {name: name, cohort: cohort.to_sym}
    if students.length == 1
      puts "Now we have #{students.count} great student."
    else
      puts "Now we have #{students.count} great students."
    end
    #now we get another name from the user
    name = gets.chomp
    cohort = gets.chomp
  end
  #return the array of students
  if students.length >= 1
    students
  else
    puts "I'm sorry, but you haven't entered any students into the directory. Please start the program again."
    exit
  end
end

#let's put all the students into an array.

=begin
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november, country: "USA"},
  {name: "Darth Vader", cohort: :november, country: "UK"},
  {name: "Nurse Ratched", cohort: :november, country: "Spain"},
  {name: "Michael Corleone", cohort: :november, country: "Italy"},
  {name: "Alex DeLarge", cohort: :november, country: "Russia"},
  {name: "The Wicked Witch of the West", cohort: :november, country: "Peru"},
  {name: "Terminator", cohort: :november, country: "UK"},
  {name: "Freddy Krueger", cohort: :november, country: "USA"},
  {name: "The Joker", cohort: :november, country: "Japan"},
  {name: "Joffery Baratheon", cohort: :november, country: "UK"},
  {name: "Norman Bates", cohort: :november, country: "USA"}
]
#we print the students
=end

def print_header
  puts "The students of Villians Academy".center(100)
  puts "--------------".center(100)
end

def print_cohort(students)
  cohort = "november".to_sym
  students.map { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)".center(100) if student[:cohort] == cohort}
end

def print(students)
  i = 0
  until i == students.size do # this loop can be used with both until and while.
    puts "#{students[i][:name]}, #{students[i][:country]} (#{students[i][:cohort]} cohort)".center(100)
    i += 1
  end
end

def print_numbered(students)
  students.each_with_index do |student, index| #each_with_index take the index of the oject in the array and lets to use it.
    puts "#{index.to_i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end


def print_student_letter(students) # this prints the students with a name of 11 or less characters.
  students.each do |student|
    if student[:name][0] == "T"
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_student_length(students) # this prints the students with a name of 11 or less characters.
  students.each do |student|
    if student[:name].length <= 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_student_country(students) # prints the students from a certain country.
  place = "UK"
  students.each {|student| puts "#{student[:name]}, #{student[:country]} (#{student[:cohort]} cohort)".center(100) if student[:country] == place}
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students.".center(100)
end
# nothing happens until will call the methods

interactive_menu
#print_cohort(students)
#print_numbered(students)
#print_student_letter(students)
#print_student_length(students)
#print_student_country(students)
