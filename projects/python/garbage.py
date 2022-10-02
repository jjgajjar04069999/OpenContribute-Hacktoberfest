import pickle

d = {1: 'hey', 2: 'ty'}

msg = pickle.dumps(d)
print(len(msg))
a = f'{len(msg):<10}' + str(msg)
print(bytes(a,'utf-8'))
# print(f'{len(msg):<10}' + msg)  # we are doing left allign
#
# msg = bytes(f"{len(msg):<{10}}",'utf-8')+msg
# # print(msg)