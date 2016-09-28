# Module that can be included (mixin) to take and output Yaml data
module YamlBuddy
  # take_yaml: takes a yaml string
  # =>         and converts it into a data structure (tsv format) in @data
  # parameter: yaml - data in YAML format
  def take_yaml(yaml)
    require 'yaml'
    @data = YAML.load(yaml)
  end

  #  converts any data in @data into a yaml string.
  def to_yaml
    require 'yaml'
    @data.to_yaml
  end
end

# This class 'Tester' is for testing the module 'TsvBuddy'
class Tester
  include YamlBuddy

  def test_take_yaml
    puts 'Test YamlBuddy take_yaml:'
    puts take_yaml(File.read('data/survey.yml'))
  end

  def test_to_yaml
    puts 'Test YamlBuddy to_yaml:'
    puts to_yaml
  end

  def test_yamlbuddy
    test_take_yaml
    puts
    test_to_yaml
  end
end

# t = Tester.new
# t.test_yamlbuddy
