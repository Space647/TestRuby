require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = 'https://www.petsonic.com/snacks-huesos-para-perros/'
html = open(url)
doc = Nokogiri::HTML(html)
node_found_by_xpath = doc.xpath('//*[@id="center_column"]/div[3]/div/div[4]/div/div[1]/div/a')
showing= node_found_by_xpath.xpath('@href')
title = node_found_by_xpath.xpath('@title')
ParsingUrl=open("#{showing}")
doc1= Nokogiri::HTML(ParsingUrl)


puts title
puts showing
