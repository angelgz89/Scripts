import speedtest

test=speedtest.Speedtest()
bajada=round((test.download()/1024/1024),0)
subida=round((test.upload()/1024/1024),0)

print(f"Velocidad de descarga: {bajada}")
print(f"Velocidad de subida: {subida}")