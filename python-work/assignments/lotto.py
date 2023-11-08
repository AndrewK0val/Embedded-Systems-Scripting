lotto = []
lottoPlus1 = []
lottoPlus2Draws = []

#ask the user if they wish to choose a quick pick or to enter in their own six lotto numbers
def mainMenu():
        
    userChoice  = input("1. quick pick\n2. manually pick six numebrs " )

    # if (userChoice != "1" or userChoice != "2"):
    #     while(userChoice != "1" or userChoice != "2"):
    #             print('Invalid option, please try again \n')
    #             userChoice  = input("1. quick pick\n2. manually pick six numebrs " )
    match userChoice:
            case "1":
                    print("you have selected quick pick")
            case "2":
                    print("you have selected manual mode")
            case _:
                  print("invalid option")
    # print("you have selected" + userChoice)           
        



mainMenu()

# if __name__ == '__main__':
#     main()
    


