# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  def construct_format_of_line_from_tsv(line, data_types)
    parsed_data = line.split("\t")
    formated_line = {}
    data_types.each_index { |i| formated_line[data_types[i]] = parsed_data[i] }
    formated_line
  end

  def construct_format_from_tsv(lines)
    data_types = lines[0].split("\t")
    lines[1..-1].map do |line|
      construct_format_of_line_from_tsv(line, data_types)
    end
  end

  def extract_data_types(target_line)
    data_types = []
    target_line.each_key { |type| data_types << type }
    data_types.reduce { |a, e| "#{a}\t#{e}" }
  end

  def construct_format_of_line_to_tsv(line_data)
    formated_line = []
    line_data.each_value { |datum| formated_line << datum }
    formated_line = formated_line.reduce { |a, e| "#{a}\t#{e}" }
  end

  def construct_format_to_tsv(content)
    data_types = extract_data_types(content[0])
    formated_lines = [data_types]
    content.each do |data|
      formated_lines << construct_format_of_line_to_tsv(data)
    end
    formated_lines = formated_lines.reduce { |a, e| "#{a}\n#{e}" }
    formated_lines += "\n"
  end

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    lines = tsv.split("\n")
    @data = construct_format_from_tsv(lines)
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    construct_format_to_tsv(@data)
  end
end

# This class 'Tester' is for testing the module 'TsvBuddy'
class Tester
  include TsvBuddy

  def test_take_tsv
    puts 'Test TsvBuddy take_tsv:'
    puts take_tsv(File.read('data/survey.tsv'))
  end

  def test_to_tsv
    puts 'Test TsvBuddy to_tsv:'
    puts to_tsv
  end

  def test_tsvbuddy
    test_take_tsv
    puts
    test_to_tsv
  end
end

# t = Tester.new
# t.test_tsvbuddy
