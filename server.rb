require 'sinatra'
require './models'
require "sinatra/reloader" if development?

get '/ping' do
  "Pong @ #{Time.now.to_i}\n"
end

post '/write' do
  start_time = Time.now
  number_of_words_to_try = params['numberOfWordsToTry'].to_i || 1
  shakespeare_words, unworthy_words = Shakespeare.new.write_with_monkeys(number_of_words_to_try)
  generate_response(start_time, shakespeare_words, unworthy_words)
end

def generate_response(start_time, shakespeare_words, unworthy_words)
  result = "SHAKESPEARE WORDS:\n"
  shakespeare_words.each do |word|
    result << word << "\n"
  end
  result << "UNWORTHY WORDS CREATED: #{unworthy_words.size}\n"
  result << "In #{ (Time.now - start_time) * 1000000} us\n"
  result
end
