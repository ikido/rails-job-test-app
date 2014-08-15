class Payment < ActiveRecord::Base

  def self.save_payment_attributes(options = {})

    # clone attributes, to keep original copy
    attributes = options.dup

    line_item_id = attributes.delete(:line_item_id)
    service_id = attributes.delete(:service_id)

    unique_payment_attributes = {
      line_item_id: line_item_id,
      service_id: service_id
    }

    # we try to fetch existing payment object
    payment = Payment.where(unique_payment_attributes).first

    # if it does not exist, we try to create it.
    if payment.blank?
      # but we watch for a ActiveRecord::RecordNotUnique exception,
      # and try to fetch
      begin

        # this method added for testing concurrency
        before_payment_create_hook(attributes)

        payment = Payment.create(unique_payment_attributes)
      rescue ActiveRecord::RecordNotUnique
        payment = Payment.where(unique_payment_attributes).first
      end
    end

    # set other  attributes here
    payment.assign_attributes(attributes)
    payment.save

  end

  # this hook is called before new payment is created at save_payment class method
  # it is used for testing concurrency — we manually create payment here, to get an exception
  def self.before_payment_create_hook(attributes={}); end

end
