require "csv" # This is used so ruby can use the CSV library
@students = []

def print_menu
  puts "1. Input the student"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "5. Show students by cohort"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      which_file
      save_students
    when "4"
      which_file
      load_students(@filename)
    when "5"
      print_cohort
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
      puts ""
  end
end

private

def input_students
  puts "Please enter the names of the students."
  name = STDIN.gets.chomp
  puts "Please enter their cohort month. To finish, just hit enter twice."
  cohort = STDIN.gets.chomp.downcase

  while !name.empty? do
    cohort = "september" if cohort.empty?
    add_students(name, cohort)
    @students.length == 1 ? (puts "Added! Now we have #{@students.count} great student.") : (puts "Added! Now we have #{@students.count} great students.") # This was done to clean up the if loop. refracting it to one line. The '?' acts like the if loop.
    puts " "
    puts "Please enter another student and their cohort. If you are done, hit enter twice."
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
  end

  if @students.length >= 1
    @students
  else
    puts "I'm sorry, but you haven't entered any students into the directory. Please start the program again."
    exit
  end
end

def show_students
  print_header
  print_numbered
  print_footer
end

def save_students
  CSV.open(@filename, "wb") do |csv| 
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
    puts "Fab! The new student(s) were successfully saved!"
    puts " "
  end
end

def load_students(filename)
  CSV.foreach(@filename) do |row|
    name, cohort = row
    add_students(name, cohort)
  end
  puts ""
  puts "Done! #{@filename} has been successfully loaded!"
  puts ""
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students(@filename = "students.csv")
  elsif File.exists?(filename)
    load_students(@filename = filename)
    puts "Loaded #{@students.count} from #{filename}."
    puts ""
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def which_file
  puts "Which file would you like to save to/load from? Remember to use .csv"
  which_file = STDIN.gets.chomp
  which_file.empty? == true ? (@filename = "students.csv") : (@filename = which_file)
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

=begin The original array of students.
@students = [
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
=end #let's put all the students into an array.


def print_header
  puts "The students of Villians Academy".center(100)
  puts "--------------".center(100)
end

def print_cohort
  puts "Which cohort do you want to see?"
  cohort = gets.chomp.to_sym
  i = 0
  @students.select { |student| puts "#{i+=1}. #{student[:name]}".center(100) if student[:cohort] == cohort.downcase}
  puts "There are #{i} students in the #{cohort} cohort.".center(100)
end

def print_student_list
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)".center(100)}
end

def print_student_full
  i = 0
  until i == @students.size do # this loop can be used with both until and while.
    puts "#{@students[i][:name]}, #{@students[i][:country]} (#{@students[i][:cohort]} cohort)".center(100)
    i += 1
  end
end

def print_numbered
  @students.each_with_index { |student, index| puts "#{index.to_i+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(100)}
end


def print_student_letter
  @students.each do |student|
    if student[:name][0] == "T"
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_student_length
  @students.each do |student|
    if student[:name].length <= 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_student_country
  place = "UK"
  @students.each {|student| puts "#{student[:name]}, #{student[:country]} (#{student[:cohort]} cohort)".center(100) if student[:country] == place}
end

def print_footer
  puts "Overall, we have #{@students.count} great students.".center(100)
end

print IO.read($0)

try_load_students
interactive_menu
