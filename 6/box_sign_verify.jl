using PyCall
py"""
import nacl.utils
from nacl.public import PrivateKey, Box
# 生成Bob与Alice的私钥
alices_private_key = PrivateKey.generate()
bobs_private_key = PrivateKey.generate()
# 使用Bob与Alice的私钥生成他们的公钥
alices_public_key = alices_private_key.public_key
bobs_public_key = bobs_private_key.public_key
# Bob为发送数据做准备，使用Bob的私钥和Alice的公钥
# 创建Box对象
bobs_box = Box(bobs_private_key, alices_public_key)
# 使用Box加密数据，生成字节类型的密文
encrypted = bobs_box.encrypt(b"I am Satoshi")
# Alice创建第二个Box对象，使用Alide的私钥与Bob的公钥
# 来对Box加密的数据进行解密
alices_box = Box(alices_private_key, bobs_public_key)
# Alice使用Box对象进行解密数据
plaintext = alices_box.decrypt(encrypted)
print(plaintext.decode('utf-8'))
"""