include("blockchain.jl")
include("transactions.jl")
include("connections.jl")
include("messages.jl")
include("server.jl")
function send_message(user,message)
       write(user["socket"],string(message))
       write(uesr["socket"],"\n")
       put!(user["channel"],message)
end
function handle_message(user,message)
    if message["message"]["name"] =="ping"
        handle_ping(user,message)
    elseif message["message"]["name"]=="block"
        handle_block(user,message)
    elseif message["message"]["name"]=="transaction"
        handle_transaction(user,message)
    elseif message["message"]["name"]=="peers"
        handle_peers(user,message)
    end
end
function handle_ping(user,message)
    block_height=message["message"]["payload"]["block_height"]
    peers = get_alive_peers(20)
    user_ping = message["meta"]["address"]
    peers_message = create_peers_message(user["socket"],user["ip"],user["port"],user["channel"],peers)
    send_message(user_ping,peers_message)
    last_block1 = last_block()
    if block_height<last_block1["height"]
        chain = server.blockchain.chain[block_height:end]
        for block in chain
            send_message(user_ping,create_block_message(user["socket"],user["ip"],user["port"],user["channel"],block))
        end
    end
end
function handle_transaction(user,message)
    transaction = message["message"]["payload"]
    if py"validate_transaction"(transaction)
        if !(transaction in server.blockchain.pend_transactions)
            push!(server.blockchain.pend_transactions,transaction)
        end
        for peer in get_alive_peers(20)
            send_message(peer,create_transaction_message(user["socket"],user["ip"],user["port"],user["channel"],transaction))
        end
end
function handle_block(user,message)
    block = message["message"]["payload"]
    user1_socket = message["meta"]["address"]["socket"]
    block1 =block
    hash = block1["hash"]
    delete!(block1,"hash")
    block1_hash= block_hash(block)
    if block1_hash != hash
        write(user["socket"],"Received tempered block")
        return 
    end
    add_block(block)
    peers = get_alive_peers(20)
    for peer in peers
        if peer != user
            send_message(peer,create_block_message(user["socket"],user["ip"],user["port"],user["channel"],block))
        end
    end
end
function handle_peers(user,message)
    peers = message["message"]["payload"]
    ping_message = create_ping_message(user["socket"],user["ip"],user["port"],user["channel"],length(server.blockchain.chain),length(get_alive_peer(50)),user["is_miner"])
    for peer in peers
        if user !=peer
            user1 = Dict([("socket",peer["socket"]),("ip",peer["ip"],("port"),peer["port"]),("is_miner",peer["is_miner"]),("channel",peer["channel"])])
            add_peer(user1)
            send_message(user1,ping_message)
        end
    end
end


