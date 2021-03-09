class TestMessage
  require 'json'

  def self.send
    File.open("./json/sample.json") do |file|
      hash = JSON.load(file)
      p hash
    end
  end
end