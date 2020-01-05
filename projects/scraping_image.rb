require 'mechanize'

def scraping_image(link)
    agent = Mechanize.new
    page = agent.get(link)
    image_url = page.at('.pictBox img').get_attribute('src')
    return image_url
end

  links = [] # 個別ページのリンクを保存する配列
  agent = Mechanize.new
  current_page = agent.get("http://eiga.com/now/")
  # 個別ページのリンクを取得
  elements = current_page.search('.m_unit h3 a')

  elements.each do |ele|
    links << ele.get_attribute('href')
  end

  links.each do |link|
    puts scraping_image('http://eiga.com' + link)
  end