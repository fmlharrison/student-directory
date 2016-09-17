@students = [] # an empty array accessible to all methods

def print_menu # extracting the code that prints the menu into it own method. this is refracting
  puts "1. Input the student"
  puts "2. Show the studetns"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    # 1. print the menu and ask th use what to do
    print_menu
    # 2. read the input and save it into a variable
    process(STDIN.gets.chomp) # this tells the selection of the user to get chomp.
  end# 3. do what the user has asked
end

def show_students # extracting the code that shows the students into it own method. this is refracting
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students #we have called the input_students methond here.
    when "2"
      show_students # call the method that shows the students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will terminate the program
    else
      puts "I don't know what you meant, try again"
  end
  # 4. repeat from step 1
end

private

def input_students
  puts "Please enter the names of the students."
  name = STDIN.gets.chomp
  puts "Please enter their cohort month. To finish, just hit enter twice."
  cohort = STDIN.gets.chomp

  #while the name variable is not empty, repeat the following code.
  while !name.empty? do
    cohort = "september" if cohort.empty?
    #add the student hash to the array
    add_students(name, cohort)
    #@students << {name: name, cohort: cohort.to_sym}
    if @students.length == 1
      puts "Now we have #{@students.count} great student."
    else
      puts "Now we have #{@students.count} great students."
    end
    #now we get another name from the user
    puts "Please enter another students and their cohort. If you are done, hit enter twice."
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
  end
  #return the array of students
  if @students.length >= 1
    @students
  else
    puts "I'm sorry, but you haven't entered any students into the directory. Please start the program again."
    exit
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w") # this is the method to open files "student.csv" is the filename and "w" means we can write to it.
  # iterate over the array of students processing one student at a time
  @students.each do |student| # every iteration we create a new array with the student info
    student_data = [student[:name], student[:cohort]] # the array is created in order to convert it to a comma separated string.
    csv_line = student_data.join(",") # the joins the elements of the array together a makes a csv formated line.
    file.puts csv_line # finally we write the line to the file using 'puts' - so it puts the line in the file not the screen.
    # when we puts without a file reference, ruby assumes that we want to write to standard output (STDOUT) - ie the screen/command line.
  end
  file.close # everytime a file is opened it must be closed.
end

def load_students(filename = "students.csv") # the method that loads the file of students from start up and is used to access to ARGV, with "students.csv" being the default value.
  file = File.open(filename, "r") # first we open the specific filename and make it readable.
  file.readlines.each do |line| # then we iterate over 'each' line in the file using 'readlines'
  name, cohort = line.chomp.split(',')
  # the trailing character line is discarded and it is split at the comman ','
  # (which is then discarded) and assigned to 2 variables at the same time: 'name, cohort' => this is called parallel assignment.
  # If the assigned value is an array, then the first variable will get the first value of the array,
  # the second variable – the second value and so on. Eahc line has 2 values, so the the new array will only have 2 values.
    add_students(name, cohort) # The line is put in a new hash usinf {} and pushed to the @student array.
  end
  file.close # the file is closed.
end

def try_load_students # this method is used to load an existing (or not) file to be used at launch of the program.
  filename = ARGV.first # first argument from the command line. e.g. ruby directory.rb 'students.csv' <- this is the filename.
  if filename.nil?
    load_students(filename = "students.csv") # This is to load the file "students.csv" by default even if no file is given in the CL.
  elsif File.exists?(filename) # if it exists.
    load_students(filename) # calls the load_students method with the given filename as the argument
    puts "Loaded #{@students.count} from #{filename}."
  else # if it doesn't exists
    puts "Sorry, #{filename} doesn't exist."
    exit # quits program
  end
end

def add_students(name, cohort) # This method is used to replace the block below in the other methods.
  @students << {name: name, cohort: cohort.to_sym}
end

=begin
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
  cohort = "november".to_sym
  @students.map { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)".center(100) if student[:cohort] == cohort}
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(100)
  end
end

def print_student_full
  i = 0
  until i == @students.size do # this loop can be used with both until and while.
    puts "#{@students[i][:name]}, #{@students[i][:country]} (#{@students[i][:cohort]} cohort)".center(100)
    i += 1
  end
end

def print_numbered
  @students.each_with_index do |student, index| #each_with_index take the index of the oject in the array and lets to use it.
    puts "#{index.to_i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end


def print_student_letter # this prints the students with a name of 11 or less characters.
  @students.each do |student|
    if student[:name][0] == "T"
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_student_length # this prints the students with a name of 11 or less characters.
  @students.each do |student|
    if student[:name].length <= 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_student_country # prints the students from a certain country.
  place = "UK"
  @students.each {|student| puts "#{student[:name]}, #{student[:country]} (#{student[:cohort]} cohort)".center(100) if student[:country] == place}
end

def print_footer
  puts "Overall, we have #{@students.count} great students.".center(100)
end
# nothing happens until will call the methods
try_load_students
interactive_menu
#print_cohort(students)
#print_numbered(students)
#print_student_letter(students)
#print_student_length(students)
#print_student_country(students)
