#!/usr/bin/env python3

print('lickthecheese\'s assorted code.org modulus cracking tools')

def crack():
    print('note: if no valid keypair exists, it will continue searching forever.')
    print('press CTRL+c to cancel')
    m = int(input('pub modulus> '))
    p = int(input('pub key> '))
    n = int(input('pub number> '))
    
    i = 1
    
    while p*i % m != 1:
        i=i+1
     
    print('done!')
    print('alice\'s secret key is ', i)
    print('bob\'s secret number is', ((i*n)%m))

def genbob():
    m = int(input('pub modulus> '))
    p = int(input('pub key> '))
    n = int(input('secret number> '))
    
    print('bob\'s public number is', ((p*n)%n))

if __name__ == '__main__':
    print('0 crack secret key and number')
    print('1 generate public number')
    
    choice = int(input('choose tool> '))
    func = [crack, genbob][choice]
    
    func()

