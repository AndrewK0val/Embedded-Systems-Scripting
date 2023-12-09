import random
import webbrowser
import urllib.request
import re

userNumbers  = []
lottoBonus = []
lottoPlus2Draws = []
lottoWinningNumbers = []

#ask the user if they wish to choose a quick pick or to enter in their own six lotto  numbers
def mainMenu():
    lottoWinningNumbers, bonusNumber = findWinningNumbers()
    # print("winning numbers: ", lottoWinningNumbers, "bonus: ", bonusNumber)
    userChoice  = input("1. quick pick\n2. manually pick six numebrs " )

    match userChoice:
        case "1":
            print("you have selected quick pick")
            userNumbers , lottoBonus = quickPick()
            print("userNumbers  list: ", userNumbers , "bonus: ", lottoBonus)
        case "2":
            print("you have selected manual mode")
            userNumbers , lottoBonus = manualMode()
            print("userNumbers  list: ", userNumbers , "bonus: ", lottoBonus)
        case _:
            print("invalid option")

    matchingNumbers = findMatchingNumbers(lottoWinningNumbers, userNumbers )
    bonusMatch = bonusNumber == lottoBonus

    print("Matching numbers: ", ', '.join(map(str, matchingNumbers)))
    if bonusMatch:
        print("Bonus number matched!")

    if len(matchingNumbers) == 3 and bonusMatch:
        print("3 numbers and bonus match! you won a cash prize ")
    elif len(matchingNumbers) == 4 and bonusMatch:
        print("4 numbers and bonus match! you won a bigger cash prize ")
    elif len(matchingNumbers) == 5 and bonusMatch:
        print("5 numbers and bonus match! you win a jackpot!")
    elif len(matchingNumbers) == 3:
        print("3 numbers match! you won a scratch card ")
    elif len(matchingNumbers) == 4:
        print("4 numbers match! you won a cash prize ")
    elif len(matchingNumbers) == 5:
        print("5 numbers match! you win a bigger cash prize!")
    elif len(matchingNumbers) == 6:
        print("Jackpot! you're now rich!")
    else: 
        print("sorry, better luck next time -keep gambling!")

    # print("you have selected" + userChoice)


def findMatchingNumbers(winningNumbers, userNumbers):
     set1 = set(winningNumbers)
     set2 = set(userNumbers)
     matchingNumbers = set1 & set2
     return list(matchingNumbers)

# populating winning numbers array with actual winnings from lotto.ie
def findWinningNumbers():
    n = 1  # number of draw results to return back
    user_agent = 'Mozilla 5.0 (Windows; U; Windows NT 5.1; en-Us; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7'
    urlLotto = "https://resultsservice.lottery.ie/rest/GetResults?drawType=Lotto&lastNumberOfDraws=" + str(n)
    headers = {'User-Agent': user_agent, }
    request = urllib.request.Request(urlLotto, None, headers)
    response = urllib.request.urlopen(request)
    data = response.read().decode('utf-8')
    lottoResults = re.findall("<Number>(.*?)</Number>", data, re.DOTALL)

    winningNumbers = [int(num) for num in lottoResults[:-1]]  # Exclude the last number
    bonusNumber = int(lottoResults[-1])  # The last number is the bonus number

    return winningNumbers, bonusNumber



def quickPick():
    random.randrange(1, 45, 1)
    numbers = []
    bonusNumber = []
    for i in range(6):
        while True:
            randomNumber = random.randrange(1, 45, 1)
            if randomNumber not in numbers:
                numbers.append(randomNumber)
                break
    bonusNumber = random.randrange(1, 45, 1)
    # bonusNumber.append(random.randrange(1, 45, 1))
    # print("your numbers are: " + ", ".join(map(str, numbers)))
    return numbers, bonusNumber


# I'll admit I didn't come up with this one but its genius
# The expression min(n % 10, 4) is used to determine the index for the list ['th', 'st', 'nd', 'rd', 'th'] which contains the ordinal suffixes.
# If n % 10 is greater than 4, min(n % 10, 4) will return 4.
# This is because the ordinal suffixes for numbers ending in 4, 5, 6, 7, 8, 9, and 0 are all 'th
def ordinal(n):
    suffix = ['th', 'st', 'nd', 'rd', 'th'][min(n % 10, 4)]
# The special case where the number ends in 11, 12, or 13 is handled separately
# with the if 11 <= (n % 100) <= 13 condition, because these numbers have 'th' as their suffix regardless of their last digit.
    if 11 <= (n % 100) <= 13:
        suffix = 'th'
    return str(n) + suffix     

def manualMode():
    numbers = []
    bonusNumber = []
    print("please pick a number between 1 and 45")
    for i in range(6):
        while True:
            choice = int(input(f"enter the {ordinal(i+1)} number \n"))
            if(choice > 45 or choice < 1 ):
                print("invalid input (must be betweeen 1 and 45)")
            elif choice in numbers:
                 print("numbers bust be unique!")
            else:
                numbers.append(choice)
                break
    bonusNumber = int(input("now pick a bonus number\n"))
    # print("your numbers are: " + ", ".join(map(str, numbers)))
    return numbers, bonusNumber

if __name__ == '__main__':
    mainMenu()


        
# Winning combinations:
# 
# - Match all 6 numbers with user numbers – wins jackpot 
# - Match any 5 numbers with any 5 user numbers – wins cash prize 
# - Match any 4 numbers with any 4 user numbers – wins cash prize  
# -  Match any 5 numbers and the bonus number with 6 user numbers – wins cash prize 
# -  Match any 4 numbers and the bonus number with any 5 user numbers – wins cash prize  
# -  Match any 3 numbers and bonus number with any 4 user numbers – wins a cash prize
# - Match any 3 numbers wins lottery scratch card   
# - None of the above - not a winner


# Marks Breakdown:
# 
#     Creation of 3 lotto  arrays and population with unique random numbers - 15%
#     Creation of userNumbers list and population based on a choice from the user - 20%
#     Creation of one function that checks userNumbers array against each lotto  list for bonus number, number of matches and outputs the winnings - 45%.
#     Comments, code indentation, additional validation and options/display to the user etc. (refer to Notes section above) - 20%