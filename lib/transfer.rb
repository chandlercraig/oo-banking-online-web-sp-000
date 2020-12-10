require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

@@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @@all << self
  end

  def self.all
    @@all
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    # binding.pry
    if self.valid? && self.status != "complete"
      sender.withdraw(amount)
      receiver.deposit(amount)
      self.status = "complete"
    elsif sender.balance < amount
      self.status = "rejected"
      self.status
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && @receiver.balance > amount && status == "complete"
      receiver.withdraw(amount)
      sender.deposit(amount)
      self.status = "reversed"
    end
  end

end
