using SHA
import Dates
using  JSON
using Random
# 构造区块结构体，结构体内参数类型创建后可以更改
mutable struct Block
    height::Int64
    timestamp::Dates.DateTime
    # transactions::Array{Transactions}
    previous_hash::String
    nonce::String
    target::String
end
# 构造区块链结构体，结构体内参数类型可以更改
mutable struct Blockchain
    chain::Array{Block}
    # pending_transactions::Array{Transactions}
    target::String
end
# 初始化区块链函数，实例化区块链对象，并且给定初始约束与创建起源块
function init(blockchain::Blockchain)
    blockchain.chain=[]
    # blockchain.pending_transactions=[]
    blockchain.target=blockchain.target
    block1=new_block(blockchain)
    push!(blockchain.chain, block1)
end
# 生成区块
function new_block(blockchain::Blockchain)
    # 若区块为空，那么生成起源块
    if length(blockchain.chain)==0
        previous_hash="genesis block"
        block = create_block(length(blockchain.chain),Dates.now(Dates.UTC),previous_hash,randstring(),blockchain.target)
    else
        # block = create_block(length(blockchain.chain),Dates.now(Dates.UTC),blockchain.pending_transactions,hash(last_block(blockchain)),randstring(),blockchain.target)
        block = create_block(length(blockchain.chain),Dates.now(Dates.UTC),block_hash(last_block(blockchain)),randstring(),blockchain.target)
        # blockchain.pending_transactions={}
    end
    return block  
end
# 创建及初始化区块实例对象

function create_block(height::Int64,timestamp::Dates.DateTime,previous_hash::String,nonce::String,target::String)
    # block=Block(height,timestamp,transactions,previous_hash,nonce,target)
    block=Block(height,timestamp,previous_hash,nonce,target)
    return block
end
# 计算出十六进制形式的区块hash值，转换为字符串形式后返回结果
function block_hash(block::Block)
    hex_hash=bytes2hex(sha256(JSON.json(block)))
    return string(hex_hash)   
end
# 获取区块链中的最后一个区块
function last_block(blockchain::Blockchain)
    if length(blockchain.chain)!=0
        return blockchain.chain[end]
    end
    return nothing
end
# 验证区块的hash值是否满足这个区块当时生成时的hash约束条件
function valid_block(block::Block)
    return block_hash(block)<block.target
    
end
# 添加区块到区块链中
function add_block(block::Block,blockchain::Blockchain)
    push!(blockchain.chain, block)
end
# 新的区块的挖掘过程(新货币在这个过程中产生-由于未添加交易池与交易账本到区块链中,暂未实现新货币产生的例子),工作量证明算法
function proof_of_work(blockchain::Blockchain)
    # 获取区块链中的最后一个区块,查看区块下标,
    while true
        new_block1=new_block(blockchain)
        if valid_block(new_block1)
            push!(blockchain.chain, new_block1)
            break
        end
    end
    
end
target = "0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
print(target)
blockchain = Blockchain([],target)
init(blockchain)
print("\n区块结构：\nBlock:{\nheight:",blockchain.chain[1].height,"\ntimestamp:",blockchain.chain[1].timestamp,"\nprevious_hash：",blockchain.chain[1].previous_hash,"\nnonce：",blockchain.chain[1].nonce,"\ntarget:",blockchain.chain[1].target,"\n}")
print("\n当前区块的hash值：",block_hash(blockchain.chain[1]),"\n")
i=2
while i<11
     proof_of_work(blockchain)
     print("\n区块结构：\nBlock:{\nheight:",blockchain.chain[i].height,"\ntimestamp:",blockchain.chain[i].timestamp,"\nprevious_hash：",blockchain.chain[i].previous_hash,"\nnonce：",blockchain.chain[i].nonce,"\ntarget:",blockchain.chain[i].target,"\n}")
     print("\n当前区块的hash值：",block_hash(blockchain.chain[i]),"\n")
     global i+=1
end