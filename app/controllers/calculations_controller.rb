class CalculationsController < ApplicationController

  def word_count_form

    render("word_count_form.html.erb")
  end


  def word_count
    #params = {"user_text"=>"harmesh", "user_word"=>"hello"}

    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    @spaces_count = @text.count(' ')

    @character_count_without_spaces = @character_count_with_spaces - @spaces_count

    @word_count = @text.split(/\s+/).length

    @occurrences = @text.split(' ').count(@special_word)

    render("word_count.html.erb")
  end

  def loan_payment_form

    render("loan_payment_form.html.erb")
  end

  def loan_payment
    # params = {"annual_percentage_rate"=>"5", "number_of_years"=>"30", "principal_value"=>"10000"}

    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    payments = @years * 12

    effective_r = @apr / 1200

    denominator = 1 - ((1 + effective_r) ** (payments * -1))

    @monthly_payment = @principal * effective_r / denominator

    render("loan_payment.html.erb")
  end

  def time_between_form

    render("time_between_form.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    render("time_between.html.erb")
  end

  def descriptive_statistics_form

    render("descriptive_statistics_form.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count - 1]

    @range = @maximum - @minimum

    if  @count.odd? == true
        @median = @sorted_numbers[(@count + 1) / 2]
    else
        @median = (@sorted_numbers[@count / 2] + @sorted_numbers[(@count/ 2) + 1])/2
    end

    @sum = @numbers.inject 0, :+

    @mean = @sum / @count

    @variance = @numbers.inject(0.0) {|s,x| s + (x - @mean)**2} / @count

    @standard_deviation = @variance ** 0.5

    count = Hash.new(0)

    @numbers.each {|number| count[number] +=1}

    @mode = count.invert.keys.sort.last

    render("descriptive_statistics.html.erb")
  end
end
