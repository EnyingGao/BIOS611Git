def func1(x):
    print(id(x))
    x = 7
    print(id(x))

def func2(l):
    print(id(l))
    l.append(2)
    print(id(l))

x = 2
id(x)
func1(x)
id(x)
print x #Doesn't change x

l1 = [1]
id(l1)
func2(l1)
print l1
