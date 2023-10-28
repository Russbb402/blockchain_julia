using PyCall
py"""
# import nacl.encoding
# import nacl.signing
# bobs_private_key = nacl.signing.SigningKey.generate()
# bobs_public_key = bobs_private_key.verify_key
# bobs_public_key_hex = bobs_public_key.encode(encoder = nacl.encoding.HexEncoder)
# verify_key = nacl.signing.VerifyKey(bobs_public_key,encoder = nacl.encoding.HexEncoder)
# signed = bobs_private_key.sign(b"Send $37 to Alice",encoder = nacl.encoding.HexEncoder)
# signed = signed_message
# verify_key.verify(signed_message)
bobs_public_key = b'71ae074bece76b79ab18923c6fe1a1437fee2c99f839ce97a6fbec5713ecd074'
verify_key = nacl.signing.VerifyKey(bobs_public_key, 
encoder=nacl.encoding.HexEncoder)
signed_message =b'T\x80[\xa0\xda\x92\xdbs\xfe\xedw\n\xad\x1bl\xcaZ:g\xc4\xf1\x8fs\xd0\x94\xa4[C\xc9\xfd\xf7\xfc^te:\xebCS\xf0\xb9\x8b\x9ab\x1a\x87\xcb\xd7ED\xb9X\xbb\x19\xbar\xb4\x98\x80\xca\xd4\x8c\x18\x0bSend $37 to Alice'
verify_key.verify(signed_message)
"""