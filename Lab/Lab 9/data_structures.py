
x = 2
x += 1
y = int(3)
z = float(3)
z = 3.0
x/y
x/z

s1 = 'abc'
s2 = str(2)
sentence = "The quick brown fox jumps over the lazy dog"
sentence.split(" ")
s1+s2

l1 = list()
l1.append(1)
l2 = [1,2,3]
l2.extend([4,5])
l2.pop()
l2[1:]
l2[:3]
l2[:-1]
sum(l2)
len(l2)
#Can put anything inside a list
l3 = [[1,2,3],[4,5,6]]
l4 = ['a',2]

#tuples are immutable
t1 = (1,2)
t1[0] = 2

#Dictionary: (key,value) pairs key must be a hashable object
d1 = dict()
d2 = {'a':1, 'b':2}
d2.items()


#Sets: an unordered collection with no duplicate elements
s1 = {1,1,2,3}
s2 = {1}
print(s1)
print(s1-s2)

squares = []
for x in range(5):
    squares.append(x*x)

squares = [x*x for x in range(5)]
squares = map(range(5), lambda x: x*x)

for x,y in d2.items():
    print(x,y)

test1 = True or False
test2 = not False and True

1 is 1
[1] is [1]
a = [2]
b = a
b is a
