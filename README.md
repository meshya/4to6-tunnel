# 4to6 tunnel
Ok! you all heard about 6to4 tunnel it is similiar with this advantantages :

1. Your effective ip address between two servers will be v6
2. ipv6 is cheap and easy to change after blocking
3. your ipv4 in both side will be safe from blocking

## How it technically works

There is two nodes A and B


 Tehran ------------------GFW----------------- Tokyo 

&nbsp; &nbsp; &nbsp;A <--------------------------------------------> B


we gonna make a tunnel between this two node

 Tehran ------------------------------------------GFW----------------------------------------- Tokyo 
 

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; A &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; B

&nbsp; &nbsp; &nbsp;| virtual ipv4 <---- 4to6 ----> real ipv6 | <------ipv6-----> | real ipv6 <---- 4to6 ----> virtual ipv4 |

In fact ipv4 packets encodes in ipv6 packets and sends to network throw ipv6

if any ip blocks it's be ipv6 and will replaces easy with another one because ip6 is cheeper than ip4 at all
