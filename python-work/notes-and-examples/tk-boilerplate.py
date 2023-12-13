from tkinter import *
from tkinter.ttk import Combobox # needed for Combobox - provides a set of themed widget classes that can be used to create fancy GUIs
def sel():
    s=""
    selection = levelChoice.get()
    if selection == 1:
        s="Easy"
    elif selection == 2:
        s="Normal"
    elif selection == 3:
        s="Difficult"
    else:
        s="Nothing"
    lblChoice.set("You selected option " + s)
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


levelChoice = IntVar(value=1)
lblChoice = StringVar()
frame = LabelFrame(initialWindow, text='Select Level', padx=50, bg='#dddddd')
frame.grid(row=1, padx=10, pady=20)
levelList = Combobox(frame, width = 25, textvariable=lblChoice)
levelList['values'] = ('Easy','Normal','Difficult')
levelList.grid(column = 0, row = 2)
levelList.current()
Label(frame, textvariable=lblChoice, width=25, height=2).grid(row=4, column=0,
columnspan=4, padx=5, pady=5)
Button(frame, text="Start Game", command=initialWindow.destroy).grid(column=0,
row=5, padx=10, pady=10)
# Create main window here
window = Tk()
width = 800 # Width
height = 500 # Height
window.title('My centered window')
# Calculate Starting X and Y coordinates for Window
screen_width = window.winfo_screenwidth() # Width of the screen
screen_height = window.winfo_screenheight() # Height of the screen
x = (screen_width/2) - (width/2)
y = (screen_height/2) - (height/2)
window.geometry('%dx%d+%d+%d' % (width, height, x, y))
window.resizable(0, 0)
window.config(bg='lightblue')
window.mainloop()