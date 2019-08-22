import sys

def add_up(x):
    return sum(x)

if __name__ == "__main__":#determining if the current file is the main module
    print "This is the name of the script: ", sys.argv[0]
    print "Number of arguments: ", len(sys.argv)
    print "The arguments are: " , str(sys.argv)
    print add_up([int(sys.argv[1]), int(sys.argv[2])])