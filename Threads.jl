using Dates
function greet(name::String,delay::Int)
    sleep(delay)
    print(name,": I waited $(delay) seconds before saying hello ∇") 
end
function concurrency()
    start_time = Dates.time()
    print("0.00s: Program Strat\n")
    @sync begin
        print(Threads.nthreads(),"\n")
        Threads.@spawn begin
            greet("t1",3)
            print("————线程编号：",Threads.threadid(),"concurrency_sync t1","\n"
            )
        end
        Threads.@spawn begin
            greet("t2",2)
            print("————线程编号：",Threads.threadid(),"concurrency_sync","\n")
        end
        Threads.@spawn begin
        greet("t3",2)
        print("————线程编号：",Threads.threadid(),"concurrency_sync","\n")
        end
    end
    End_time =Dates.time()-start_time
    print("$(End_time)s:concurrency_sync Program End\n")
end
concurrency()