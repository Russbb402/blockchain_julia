using SHA
open("D:\\julia\\funcoin\\2\\image.jpg")  do file
    print(bytes2hex(sha256(file)),"\n")
end
open("D:\\julia\\funcoin\\2\\image_modified.jpg")  do file
    print(bytes2hex(sha256(file)))    
end