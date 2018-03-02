# Crypto_Encryption
Programming Assignment 2: Using Openssl


notes
openssl enc -aes-128-cbc -a -salt -iv 01020304 -in pic_original.bmp -out task2cbc.bmp
openssl enc -aes-128-cbc -d -a -salt -iv 01020304 -in task2cbc.bmp -out cbcdec.bmp

