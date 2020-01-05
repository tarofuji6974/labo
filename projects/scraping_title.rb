require 'mechanize'

agent = Mechanize.new
page = agent.get("http://eiga.com/now/")

elements = page.search('.m_unit h3 a')


elements.each do |ele|
    puts ele.inner_text
end