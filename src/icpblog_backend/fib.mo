
module{
    public func fib(n : Nat) : Nat{
        if(n <= 1){
        1
        }else{
        fib(n-1) + fib(n-2)
        }
    };
}

