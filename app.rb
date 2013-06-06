require 'sinatra'
require 'yaml'

Entry = Struct.new(:name, :link, :author, :desc)

class App < Sinatra::Base
  def self.entries
    @entries
  end

  def self.entries=(values)
    @entries = values
  end

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

  get '/' do
    erb :list, locals: { entries: self.class.entries }
  end
end

App.entries = YAML.load_file("#{File.dirname(__FILE__)}/list.yml").map do |hash|
  Entry.new hash.fetch('name'), hash.fetch('link'), hash.fetch('author'), hash.fetch('description')
end
