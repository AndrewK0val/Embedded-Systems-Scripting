def hello(**fnames):
    for key, value in fnames.items(): #the items() method returns a list with all dictionary keys with values
        print("Hello " + key + " " + value)

hello(fname1="Fergal", fname2="Mark", fname3="Damien", fname4="Kelly")

