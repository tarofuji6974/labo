require 'mechanize'

agent = Mechanize.new
page = agent.get("http://mooovi.tech-camp.in/works/third_scraping")

elements = page.search('div.etc div')


elements.each do |ele|
    puts ele.inner_text
end