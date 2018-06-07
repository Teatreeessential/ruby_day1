require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'sinatra/reloader'
require 'json'


get '/check_lotto' do
    url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    lotto = HTTParty.get(url)
    result = JSON.parse(lotto) 
    numbers = []
    bonus = result["bnsNo"]
    
    
    result.each do |k,v|
        if k.include?("drwtNo")
            numbers << v
        end
    end
    my_numbers = *(1..45)
    my_lotto = my_numbers.sample(7).sort
    count = 0
    numbers.each do |num|
        if my_lotto.include?(num) 
            count += 1
        end
    end
 
  
    
    case count
        when 6
            puts '1등 입니다.'
        when 5
         if my_lotto.include?(bonus)
             puts '2등 입니다.'
         else 
             puts '3등 입니다.'
         end
        when 4
            puts '4등 입니다.'
        when 3
            puts '5등 입니다.'
        else
            puts '미당첨 입니다 ㅠ'
    end
        
         
  
end




get '/html_file' do 
    @name = params[:name]
    erb:my_first_html
end

get '/calculate' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    @result1 = num1+num2
    @result2 = num1-num2
    @result3 = num1*num2
    @result4 = num1/num2
    erb:my_calculate
end     
    