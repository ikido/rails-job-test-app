# Usage:
#
# LuhnValidator.is_valid_number?(79927398713)
# => true
#
# LuhnValidator.is_valid_number?(79927398712)
# => false
#
# LuhnValidator.append_check_digit(7992739871)
# => 79927398713
#

class LuhnValidator

  def self.is_valid_number?(number)
    validate_number_argument(number)
    check_digit = calculate_check_digit(number: number)
    return check_digit == number % 10
  end

  # calculate and append check_digit
  def self.append_check_digit(number)
    validate_number_argument(number)

    # calculate check digit, and tell method that check digit
    # is not included
    check_digit = calculate_check_digit(
      number: number,
      number_without_check_digit: true
    )

    return "#{number}#{check_digit}".to_i
  end

private

  # validates argument, currently we expect an integer
  def self.validate_number_argument(number)
    raise ArgumentError, 'Wrong argument: please supply an integer number' unless number.kind_of?(Integer)
  end

  # calculate check digit
  def self.calculate_check_digit(options = {})
    calculate_luhn_sum(options) * 9 % 10
  end

  # cumputes luhn sum from any number
  #
  # options hash must include :number (integer), and an optional
  # :number_without_check_digit=true, to designate that check digit
  # is not appended to the number, and thus should not be skipped
  def self.calculate_luhn_sum(options = {})
    number = options.delete(:number)
    number_without_check_digit = options.delete(:number_without_check_digit)

    # remove last (check) digit from number if it is included (by default), if
    # included in number (by default)
    number = number.to_s[0..-2].to_i unless number_without_check_digit

    # get reversed array of digits
    digits = split_digits(number).reverse

    # for each digit compute its doubled value, and returns new
    # number as a string. Each doubled digit can't be more than 9
    luhn_number = digits.map.with_index do |digit, position|

      # for each even digit we compute doubled value
      if position.even?
        # double it
        digit *= 2

        # and sum its digits if the result is git
        digit > 9 ? sum_digits(digit) : digit

      # odd digits are left intact
      else
        digit
      end
    end.join('')

    return sum_digits(luhn_number)
  end

  # sum digits in a number
  def self.sum_digits(number)
    split_digits(number).inject(:+)
  end

  # returns array of digits of passed number
  def self.split_digits(number)
    number.to_s.chars.map(&:to_i)
  end

end