
module ActiveRecord
  class Schema
    def self.define(version:)
      puts "loading #{version}"
      yield
    end
  end
end

MODULE_PATH = %w[Chime Migrations].freeze
RUBY_MODELS_PATH = '../server-core/app/models'.freeze

def sym(s)
  ":#{s}"
end

def commas(items)
  items.join(', ')
end

def indent(depth, line)
  puts "#{'  ' * depth}#{line}"
end

def options(hash_or_nil)
  (hash_or_nil || {}).to_a.map { |k, v| "#{k}: #{v == '' ? '""' : v}" }
end

class Field
  def initialize(type, name, options)
    @type = type
    @name = name
    @options = options
  end

  def options_to_s
    options(@options)
  end

  def to_s
    "field(:#{@name}, #{commas([sym(@type)] + options_to_s)})"
  end
end

class Table
  attr_reader :table_name, :fields, :model

  def initialize(table_name, options)
    @table_name = table_name
    @options = options
    @fields = []
    @model = MODELS[class_name] || Model.new(class_name)
  end

  def file_name
    @table_name.singularize
  end

  def class_name
    file_name.camelize
  end

  def module_name
    (MODULE_PATH + [class_name]).join('.')
  end

  def method_missing(type, name, *list_of_one_hash)
    @fields << Field.new(type, name, list_of_one_hash.first)
  end

  def index(*args); end

  def display_module
    indent(0, "\ndefmodule #{module_name} do")
    indent(1, 'use Ecto.Schema')
    indent(1, 'import Ecto.ChangeSet')
    model.paths.each { |path| indent(1, "# from #{path}") }
    indent(1, "schema \"#{table_name}\" do")
    fields.each { |field| indent(1, field) }
    model.display_relationships
    indent(1, "end\n")
    model.display_changeset
    indent(0, 'end')
  end
end

require 'active_support/inflector'

class Model
  attr_reader :paths, :relationships

  def initialize(name)
    @name = name
    @paths = []
    @relationships = Set.new
  end

  def add_path(path)
    return if path.include?('server-core-accessibility')
    @paths << path
    @relationships = @relationships.merge(extract_relationships(path))
  end

  def extract_relationships(path)
    `egrep '(#{RELATIONSHIPS.join('|')})' #{path}`
      .split("\n")
      .map(&:strip)
      .delete_if { |s| s.include?('->') }
  end

  def display_relationships
    relationships.each { |relationship| indent(2, relationship) }
  end

  def display_changeset
    indent(1, 'def changeset(record, attrs) do')
    indent(2, 'all_fields = Enum.map(__schema__(:fields), &Atom.to_string/1)')
    indent(2, 'all_fields')
    indent(2, '|> cast(attrs, all_fields)')
    indent(2, '|> validate_required([])')
    indent(1, 'end')
  end

  def self.from_path(path)
    path.split('/').last.gsub(/\.rb$/, '').singularize.camelize
  end
end

RELATIONSHIPS = %w[belongs_to has_one has_many has_and_belongs_to_many].freeze

def find_models
  paths = {}
  `find .. -name '*.rb' | xargs grep -l '< ActiveRecord::Base'`
  .split("\n")
  .each do |path|
    model = Model.from_path(path)
    (paths[model] ||= Model.new(model)).add_path(path)
  end
  paths
end

# def camelize(s)
#   s.split('_').collect(&:capitalize).join
# end

MODELS = find_models
TABLES = []

def create_table(table_name, options)
  table = Table.new(table_name, options)
  TABLES << table
  yield table
end

def add_foreign_key(table1, table2, *list_of_one_hash)
  indent(0,"# add_foreign_key( #{table1}, #{table2}, #{commas(options(list_of_one_hash.first))})")
end

load 'schema.rb'

TABLES.each(&:display_module)
