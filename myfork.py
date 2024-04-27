import os
import sys
import signal
import time

def sigint_handler(signum, frame):
    print("SIGINT signal recieved. Exiting...")
    sys.exit(0)

def sigtrm_handler(signum, frame):
    print("SIGTERM signal received. Exiting...")
    sys.exit(0)

def sigalarm_handler(signum, frame):
    print("!!!!!!!!!!!!!!!! SIGALRM signal received !!!!!!!!!!!!!!!!")

def sigusr1_handler(signal, frame):
    print("SIGUSR1 signal received. Doing something...")

def sigusr2_handler(signal, frame):
    print("SIGUSR2 signal received. Doing something else...")

signal.signal(signal.SIGINT, sigint_handler)
signal.signal(signal.SIGTERM, sigtrm_handler)
signal.signal(signal.SIGALRM, sigalarm_handler)
signal.signal(signal.SIGUSR1, sigusr1_handler)
signal.signal(signal.SIGUSR2, sigusr2_handler)
signal.alarm(5)

print('Hello! I am an example')
pid = os.fork()
print('pid of my child is %s' % pid)

if pid == 0:
    print('I am a child. Im going to sleep')
    for i in range(1, 40):
        print('mrrrrr')
        a = 2**i
        print(a)
        pid = os.fork()
        if pid == 0:
            print('my name is %s' % a)
            sys.exit(0)
        else:
            print("my child pid is %s" % pid)
        time.sleep(1)
    print('Bye')
    sys.exit(0)

else:
    for i in range(1, 200):
        print('HHHrrrrr')
        time.sleep(1)
        print(3**i)
    print('I am the parent')

#pid, status = os.waitpid(pid, 0)
#print "wait returned, pid = %d, status = %d" % (pid, status)
