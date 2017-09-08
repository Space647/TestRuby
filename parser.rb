require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'image_downloader'

url = 'https://www.petsonic.com/snacks-huesos-para-perros/'
html = open(url)
doc = Nokogiri::HTML(html)
node_found_by_xpath = doc.xpath('//*[@id="center_column"]/div[3]/div/div[4]/div/div[1]/div/a')
showing= node_found_by_xpath.xpath('@href')
title = node_found_by_xpath.xpath('@title')
ParsingUrl=open("#{showing}")
doc1= Nokogiri::HTML(ParsingUrl)
ing1=doc1.xpath('//*[@id="bigpic"]')
img1=ing1.xpath('@src')
pars1=doc1.xpath('//*[@id="attributes"]/fieldset/div/ul[2]/li/span[1]').text
pars2=doc1.xpath('//*[@id="attributes"]/fieldset/div/ul[2]/li/span[2]').text
File.open('1.png', 'wb') do |fo|
    fo.write open("#{img1}").read 
  end

puts img1
#puts title
#puts pars1
#puts pars2
