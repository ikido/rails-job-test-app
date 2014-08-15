require 'spec_helper'

describe Payment do

  describe "self.save_payment_attributes" do

    before do
      @attributes = {
        line_item_id: 123,
        service_id: 321,
        status: 'completed'
      }
    end

    context "when no payment with this line_item_id and service_id exists" do

      it "should create new payment with given line_item_id and service_id" do
        expect{
          Payment.save_payment_attributes(@attributes)
        }.to change{
          Payment.count
        }.by(1)
      end

      it "should assign passed attributes to created payment" do
        Payment.save_payment_attributes(@attributes)
        new_payment = Payment.last

        @attributes.each do |attr, value|
          new_payment.send(attr).should == value
        end
      end

    end

    context "when payment with this line_item_id and service_id exists" do

      before do
        @existing_payment = FactoryGirl.create(:payment, @attributes.merge(status: 'new'))
      end

      it "should assign passed attributes to existing payment" do
        expect{
          Payment.save_payment_attributes(@attributes)
        }.to_not change{
          Payment.count
        }.by(1)

        @existing_payment.reload
        @existing_payment.status.should == @attributes[:status]
      end

    end

    context "when payment is being created concurrently" do

      # monkey-patch class to simulate concurrency and
      # create another record in before_payment_create_hook
      before do
        class Payment
          def self.before_payment_create_hook(attributes={})
            FactoryGirl.create(:payment, attributes.merge(status: 'new'))
          end
        end
      end

      it "should assign passed attributes to existing payment" do
        expect{
          Payment.save_payment_attributes(@attributes)
        }.to_not change{
          Payment.count
        }.by(1)

        Payment.last.status.should == @attributes[:status]
      end

    end

  end

end