from cryptography.fernet import Fernet

def load_key():
    return open("key.key", "rb").read() 

key = load_key() 
f = Fernet(key)

def write_key():
    key = Fernet.generate_key() 
    with open("key.key", "wb") as key_file: 
        key_file.write(key) 

#write_key()
        
        
def write_msg():
    message = input("Message: ").encode()
    encrypted_message = f.encrypt(message)
    print(encrypted_message)
    with open("msg.txt", "wb") as msg: 
        msg.write(encrypted_message)

def decrypt_msg():
    encrypted_message = open("msg.txt", "rb").read() 
    decrypted_message = f.decrypt(encrypted_message)
    return decrypted_message.decode()
        
write_msg()

print(decrypt_msg())