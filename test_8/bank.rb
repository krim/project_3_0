class InvalidPeriod < StandardError
end

class Bank
  def initialize(amount, day_rate, days_count, period, debug: false)
    @amount = amount
    @day_rate = day_rate
    @days_count = days_count
    @period = period
    @debug = debug
  end

  def return_money
    validate_period
    validate_amount
    credit_info
    return_steps
  end

  def return_steps
    period_amount = need_to_return / @period
    return_amounts = Array.new(@period, period_amount)
    extra_amount = need_to_return - return_amounts.sum

    debug_message "RETURN AMOUNTS: #{return_amounts}"
    debug_message "EXTRA AMOUNT: #{extra_amount}"

    if extra_amount > 0
      return_amounts = return_amounts.map do |amount|
        if extra_amount > 0
          extra_amount -= 1
          amount += 1
        end
        amount
      end
    end

    debug_message "NEW EXTRA AMOUNT: #{extra_amount}"
    debug_message "NEW RETURN AMOUNTS: #{return_amounts}"
    debug_message "#{return_amounts.sum} == #{need_to_return}"

    return_amounts
  end

  def need_to_return
    @amount + need_to_return_percent_per_day * @days_count
  end

  def credit_info
    debug_message "Amount: #{@amount}"
    debug_message "Day rate: #{@day_rate}"
    debug_message "Days count: #{@days_count}"
    debug_message "Period: #{@period}"
    debug_message "------------------"
    debug_message "Need to return: #{need_to_return}"
  end

  private

  def debug_message(message)
    puts message if @debug
  end

  def need_to_return_percent_per_day
    @amount * @day_rate / 100
  end

  def validate_period
    raise InvalidPeriod, "Must be multiple of days count" unless @days_count % @period == 0
  end

  def validate_amount
    raise TypeError, "Amount must be integer" if @amount.to_f != @amount.to_i
  end
end
