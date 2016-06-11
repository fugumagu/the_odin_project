class Account
    
    def initialize(name, balance=100)
        info(name, balance)
    end
    
    public
    def display_balance(pin_number)
        if pin_number == @pin
            puts "Balance: $#{@balance}."
        else
            puts pin_error
        end
    end
    
    def withdraw(pin_number, amount)
        if pin_number == @pin
            @balance -= amount
            puts "Withdrew #{amount}. New balance: $#{@balance}.}"
        else
            puts pin_error
        end
    end
        
    
    private
    def pin
        @pin = 1234
    end
    
    def pin_error
        "Access denied: incorrect PIN."
    end
    
    def info(name, balance)
        @name = name
        @balance = balance
    end
end

checking_account = Account.new("Jeremy", 1_000_000)
puts checking_account.instance_variable_get :@balance