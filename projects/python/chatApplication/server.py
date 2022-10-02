import socket
import select
HEADER_LENGTH=10
ip='127.0.0.1'
PORT=1234
server_sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server_sock.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
server_sock.bind((ip,PORT))
server_sock.listen()
socket_list=[server_sock]
clients={}
def receive_message(client_socket):
    try:
        message_header=client_socket.rev(HEADER_LENGTH)
        if not len(message_header):
            return False
        message_length=int(message_header.decode('utf-8').strip())
        return {"header":message_header,"data":client_socket.recv(message_length)}
    except:
        return False
while True:
    read_sockets,_,exception_sockets =select.select(socket_list,[],socket_list)