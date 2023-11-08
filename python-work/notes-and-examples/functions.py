# use * to specify arbitrary number of arguments
# useful when you don't know the number of arguments

# def hello(*fnames):
#     for fn in fnames: 
#         print("Hello " + fn)
    
# hello("Fergal", "Mark", "Damien", "Kelly", "Sarah")
# print()

# hello("Fergal", "Mark", "Damien", "Kelly", "Sarah")

# print()

# def helloagain(*fnames):
#     print("Hello "+ fnames[1])
# helloagain("Fergal", "Mark", "Damien")

#----------------------------------------------------------------------

def hello2(fname1, fname2, fname3, fname4):
    print("Hello " + fname1)
    print("Hello " + fname2)
    print("Hello " + fname3)
    print("Hello " + fname4)

hello2(fname1="Fergal", fname2="Mark", fname3="Damien", fname4="Kelly")

def helloagain(*fnames):
    print("Hello " + fnames[1])

helloagain("Fergal", "Mark", "Damien")

def helloagain2(*fnames): 
    for fn in fnames:
        print("Hello " + fn)

helloagain2("Fergal", "Mark", "Damien")
