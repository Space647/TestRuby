require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "csv"

main_url = "https://www.petsonic.com/"      #url website
type_product = "snacks-huesos-para-perros"  #category
fileNameToSave="file"                       #file name to save

url = "#{main_url}#{type_product}/"
num_page = 0

pages_num = []
urls_full_page_product = []
full_info_product = []

def get_page(url)
  html = open(url)
  doc = Nokogiri::HTML(html)
end


common_view = get_page(url)
pages_list = common_view.xpath('//*[@id="pagination_bottom"]/ul')
pages_list.each do |page|
  page.xpath(".//a/span").each do |num|
    pages_num.push(num.text.to_i)
  end
end

max_page = pages_num.max()

1.upto(max_page) do |page|
  url_product = "#{url}?p=#{page}"
  common_view = get_page(url_product)
  list_products = common_view.xpath('//*[@id="center_column"]/div[3]/div')
  list_products.each do |url|
    real_path = url.xpath(".//div/div[1]/div/a[@class='product_img_link']/@href").to_a
    urls_full_page_product.concat(real_path)
  end
end

urls_full_page_product.each do |full_url|
  info_product = {}
  product_page = get_page(full_url)
  info_product['picture_url'] = product_page.xpath('//*[@id="bigpic"]/@src')
  info_product['product_name'] = product_page.xpath('//*[@id="right"]/div/div[1]/div/h1/text()').text.strip
  prices_list = product_page.xpath('//*[@id="attributes"]/fieldset/div')
  costs = []
  prices_list.each do |price|
costs.push({
      'type_product' => price.xpath('.//li/span[1]').text.strip,
      'price_product' => price.xpath('.//li/span[2]').text.strip
             })
  end
  info_product['costs'] = costs
  full_info_product.push(info_product)
end

CSV.open("#{fileNameToSave}.csv", "wb") do |csv|
  full_info_product.each do |value|
  csv << [value['product_name'],value['costs'],value['picture_url']]
  end
end
puts 'Done!'

