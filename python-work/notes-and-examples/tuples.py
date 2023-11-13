myTuple = ("Fergal", "John", "Mary")
myOtherTuple = (3, 5, 6, 8, 9)
myEmptyTuple = ()
myMixedTuple = (1, 2, 3, "Garret")

print(len(myTuple))
print(myTuple)

print(myTuple[2])
print(myOtherTuple[1:3])

for name in myTuple:
    print("Hello", name)
print(myMixedTuple)
