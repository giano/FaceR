#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'rubygems'
require 'ruby-debug'
gem 'multipart-post'
require "lib/facer.rb"

linkr=Facer::Linker.new("MyTest","f2615b2ab01898836d7061c7c6143536","1fb09d9383b910a1bacab866f9338838")
puts linkr.account.private_namespaces?.inspect
puts linkr.account.limits?.inspect

trainSet={
  "giano" => [
    "/Users/giano/Pictures/face600.jpg",
    "http://kotv.images.worldnow.com/images/9815269_BG3.jpg"
    ],
  "angelina" => [
    "/Users/giano/Downloads/foto3.jpg",
    "/Users/giano/Downloads/angelina-jolie1.jpg",
    "/Users/giano/Downloads/fac4.jpg",
    "/Users/giano/Downloads/angelina_jolie_wallpaper.jpg",
    "/Users/giano/Downloads/angelina_jolie.jpg",
    "http://www.smh.com.au/ffximage/2005/09/29/jolie2_wideweb__430x338.jpg"
    ],
  "vanessa" => [
    "http://www.superiorpics.com/hs/vanessa_paradis/main1.jpg",
    "http://nymag.com/daily/fashion/14_paradis_lgl.jpg",
    "http://imstars.aufeminin.com/stars/fan/vanessa-paradis/vanessa-paradis-20060208-107457.jpg",
    "http://www.realbeauty.com/cm/realbeauty/images/NF/rby-hair-vanessa-paradis-5-de.jpg",
    "http://www.wallpaperweb.org/wallpaper/babes/1280x960/vanessa_paradis_20070722_0171_1280x960.jpg",
    "http://chansons-fle.wikispaces.com/file/view/vanessa_paradis_reference.jpg/59524266/vanessa_paradis_reference.jpg"
  ]
}

trainSet.each_pair do |key,value|
  succ= linkr.faces.associate_multi(value,key,"clinik").inspect
  puts "Associating #{key}: #{succ}"
end


puts linkr.faces.train_all("clinik").inspect

puts linkr.faces.recognize("/Users/giano/Pictures/face600.jpg","clinik").inspect
puts linkr.faces.recognize("http://www.smh.com.au/ffximage/2005/09/29/jolie2_wideweb__430x338.jpg","clinik").inspect
puts linkr.faces.recognize("http://www.smh.com.au/ffximage/2005/09/29/jolie2_wideweb__430x338.jpg","clinik").inspect
puts linkr.faces.recognize("http://www.moviesense.nl/wp-content/uploads/2009/02/angelina-jolie-8.jpg","clinik").inspect
puts linkr.faces.recognize("http://www.anvari.org/db/cols/Young_Angelina_Jolie/Young_Angelina_Jolie_016.jpg","clinik").inspect
puts linkr.faces.recognize("http://static1.purepeople.com/articles/7/17/12/7/@/85769-vanessa-paradis-et-johnny-depp-637x0-1.jpg","clinik").inspect
puts linkr.faces.recognize("http://howzar.com/Galleries/Vanessa%20Paradis/vanessa-paradis-32.jpg","clinik").inspect
puts linkr.faces.recognize("http://pictures.directnews.co.uk/liveimages/Old+man+smiling_1500_19112072_0_0_7006461_300.jpg","clinik").inspect


