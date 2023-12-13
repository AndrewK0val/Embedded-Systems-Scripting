# pydictionary may need a dependency package: futures
#run: pip install futures  ---> pip install PyDictionary
import urllib.request
from string import ascii_uppercase
import random
from tkinter import *
from tkinter.ttk import Combobox
import re
guessCount = 0
correctLetters = []
# from PyDictionary import PyDictionary
# dictionary=PyDictionary()

# def main():
#     randomWord = str(fetchRandomWordFromAPI(5))
#     print(randomWord)

def fetchRandomWordFromAPI(wordLenght):
    user_agent = 'Mozilla 5.0 (Windows; U; Windows NT 5.1; en-Us; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7'
    urlAPI = f"https://random-word-api.vercel.app/api?words=1&length={wordLenght}"
    headers = {'User-Agent': user_agent, }
    request = urllib.request.Request(urlAPI, None, headers)
    response = urllib.request.urlopen(request)
    data = response.read().decode('utf-8')    
    return data

def gui():
    global lblChoice
    initialWindow = Tk()
    initialwidth = 320 # Width
    initialheight = 300 # Height
    initialWindow.title('Game Level')
    # Calculate Starting X and Y coordinates for initialWindow
    screen_width = initialWindow.winfo_screenwidth() # Width of the screen
    screen_height = initialWindow.winfo_screenheight() # Height of the screen
    x = (screen_width/2) - (initialwidth/2)
    y = (screen_height/2) - (initialheight/2)
    initialWindow.geometry('%dx%d+%d+%d' % (initialwidth, initialheight, x, y))
    initialWindow.resizable(0, 0)

    # Create label
    label = Label(initialWindow, text="This game has three levels - Easy, Normal and Difficult")
    label.grid(row=0, padx=10, pady=10) # position label on row 0 of the grid
    # Create variables and radiobuttons - using the same variable for all radiobuttons allows only one to be selected
    # levelChoice = IntVar(value=1)
    lblChoice = StringVar()
    frame = LabelFrame(initialWindow, text='Select Level', padx=50, bg='#dddddd')
    frame.grid(row=1, padx=10, pady=20)
    levelList = Combobox(frame, width = 25, textvariable=lblChoice)
    levelList['values'] = ('Easy','Normal','Difficult')
    levelList.grid(column = 0, row = 2)
    levelList.current()
    Label(frame, textvariable=lblChoice, width=25, height=2).grid(row=4, column=0, columnspan=4, padx=5, pady=5)
    Button(frame, text="Start Game", command=lambda:startGame(initialWindow, lblChoice)).grid(column=0, row=5, padx=10, pady=10)
    

    initialWindow.mainloop()



def mainGui(lblChoice, target_word):
    window = Tk()
    width = 800  # Width
    height = 500  # Height
    window.title('Hangman')
    target_list = [char for char in target_word]

    def update_display():
        displayed_word = ' '.join([letter if letter in correctLetters else '_' for letter in target_word])
        lblWord.config(text=displayed_word)
        # print(f"Correct Letters: {correctLetters}")
        # print(f"Target Word: {target_word}")
        # print(f"Updated Displayed Word: {displayed_word}")

    def attempt(letter):
        global guessCount, correctLetters
        if guessCount < 4:
            letter = letter.lower()  # Convert the guessed letter to lowercase
            if letter not in correctLetters:
                if letter in [char.lower() for char in target_word]:  # Convert target word to lowercase for comparison
                    correctLetters.append(letter)
                else:
                    guessCount += 1
                update_display()
                # debugging 
                # print(f"Correct Letters: {correctLetters}")
                # print(f"Guess Count: {guessCount}")
                # print(f"Displayed Word: {lblWord.cget('text')}")
                check_game_status()


    screen_width = window.winfo_screenwidth()  # Width of the screen
    screen_height = window.winfo_screenheight()  # Height of the screen
    x = (screen_width / 2) - (width / 2)
    y = (screen_height / 2) - (height / 2)
    window.resizable(0, 0)
    window.geometry('%dx%d+%d+%d' % (width, height, x, y))

    lblWord = Label(window, text=' '.join('_' * len(target_word)), font=('consolas 24 bold'))
    lblWord.grid(row=0, column=3, columnspan=6, padx=10)


    def create_button(frame, letter, row, column):
            return Button(frame, text=letter, font=('Helvetica 18'), width=3, command=lambda: attempt(letter)).grid(row=row, column=column, padx=5, pady=5)
    
    button_frame = Frame(window)
    button_frame.grid(row=4, column=0, columnspan=9, pady=10)

    n = 0
    for c in ascii_uppercase:
        create_button(button_frame, c, row=n // 9, column=n % 9)
        n += 1

    window.config(bg='lightblue')
    print("target word:",target_word)

    lblWord.config(text=' '.join('_' * len(target_word)))
    Button(button_frame, text="Reset", command=lambda: resetGame(window)).grid(row=2, column=8, padx=5, pady=5)

    def check_game_status():
        # Implement logic to check if the player has won or lost
        # Update the game status or take appropriate actions
        pass

    window.mainloop()



def startGame(window, lblChoice):
    global correctLetters
    window.destroy()
    target_word = generateWordBasedOnDifficulty(lblChoice)[2:-2]
    correctLetters = []  # Reset the list for a new game
    mainGui(lblChoice, target_word)


    # print(lblChoice.get())
   


def generateWordBasedOnDifficulty(lblChoice):
    wordCount=0
    if lblChoice.get() == "Difficult":
        wordCount=6
    elif lblChoice.get() == "Normal":
        wordCount=5
    elif lblChoice.get() == "Easy":
        wordCount=4
    else:
        print("error")

    target_word = fetchRandomWordFromAPI(wordCount)
    return  target_word



def resetGame(mainWindow):
    guessCount=0
    # target_word = fetchRandomWordFromAPI(wordCount)
    mainWindow.destroy()
    gui()



if __name__ == '__main__':
    # main()
    gui()
    # mainGui()


#  Using the python program structure create a hangman game for the user.
#  
#  The program randomly selects a word from a list and tell the user how many letters are in the word they have to guess.
#  
#  You are to ask the user to guess the letters contained within the word.
#  
#  You will need functions to check if the user has actually inputted a single letter, to check if the inputted letter is in the hidden word (and if it is, how many times it appears), to print letters, and a counter variable to limit guesses (num guesses should be set a size of word minus 1).  The user can exit the game at any time by entering -1 value.
#  
#  For example, if the random word a user had to guess was LINUX then the program might work as follows:
#  
#  > Guess either the letters in this 5 letter word or the word itself (you have 4 letter guesses):
#  > L
#  > Yes, the letter L appears in this 5 letter (L _ _ _ _) word (you have 3 letter guesses remaining):
#  > V
#  > No, the letter V does not appear in the word (you have 2 letterguesses remaining):
#  > I
#  > Yes, the letter I appears in this 5 letter (L I _ _ _) word (you have 1 guesses remaining):
#  > LANES
#  > No, the word is not LANES. Please try again you have 1 letter guess remaining):
#  > X
#  > Yes, the letter X appears in this 5 letter (L I _ _X) word (you have 0 guesses remaining but you have unlimited guesses for the word):
#  > LINEX
#  > No, the word is not LINEX. Please try again, you have unlimited guesses for the word):
#  > LINUX
#  > Yes, congrats you correctly guessed the word.
#  
#  Your program is first to ask the user the level of difficulty they would like to play the game at - easy, normal or hard.
#  
#  Easy - words of 5 characters or less
#  Normal - words of length 6 - 8 characters
#  Hard - words of length greater than 8 characters
#  
#  You will need to create three lists to represent words in each of these categories. 
#  
#  Each time the program is run a list of 20 words should be created from either a larger list of English words or from an api (cambridge or oxford dictionaries).