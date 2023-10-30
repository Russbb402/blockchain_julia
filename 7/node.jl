inlcude("funcoin/blockchain.jl")
include("funcoin/connections.jl")
include("funcoin/peers.jl")
include("funcoin/server.jl")
target = "00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
blockchain = Blockchain([],target,[])
init()
connection_pool = Connection_pool([])
server = Server(blockchain,connection_pool,"None","None")
l = ReentrantLock()
function main()
    listening()
end
main()