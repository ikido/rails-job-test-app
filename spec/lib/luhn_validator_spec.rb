require 'spec_helper'

describe "LuhnValidator" do

  describe "self.is_valid_number?" do

    it "should return true if number is valid according to luhn" do
      LuhnValidator.is_valid_number?(79927398713).should be_true
    end

    it "should return false if number is invalid according to luhn" do
      LuhnValidator.is_valid_number?(79927398714).should be_false
    end

  end

  describe "self.append_check_digit" do

    it "should append_check_digit to a number of any length, so that it becomes valid luhn number" do
      LuhnValidator.append_check_digit(799273987179927398717992739871).should == 7992739871799273987179927398719
      LuhnValidator.append_check_digit(7992739871).should == 79927398713
      LuhnValidator.append_check_digit(799).should == 7997
      LuhnValidator.append_check_digit(7).should == 75
      LuhnValidator.append_check_digit(0).should == 0
    end

  end

end