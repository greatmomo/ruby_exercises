require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'pry-byebug'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone(phone_number)
  cleaned = phone_number.to_s.tr('^0-9', '')
  case
  when cleaned.length > 11
    return "Bad number!"
  when cleaned.length < 10
    return "Bad number!"
  when cleaned.length == 10
    return cleaned
  when cleaned.length == 11
    return cleaned[1..-1] if cleaned[0] == '1'
  end
end

def extract_hour(reg_date)
  DateTime.strptime(reg_date, "%m/%d/%Y %H:%M").hour
end

def extract_weekday(reg_date)
  DateTime.strptime(reg_date, "%m/%d/%Y %H:%M").hour
end

puts 'Event Manager Initialized!'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

peak_hours = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])
  peak_hours[extract_hour(row[:regdate])] += 1
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

puts peak_hours

# next: Assignment: Clean Phone Numbers
