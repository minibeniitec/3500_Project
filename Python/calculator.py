'''
Student 1: Rodrigo Ortiz
Student 2: Benjamin Garza
Course: CMPS 3500
Date: 5/7/2020
Description: Scientific Calculator in Python: Final Project
'''
import pygame
import sys
import math

# Binary Operators
def add(num1, num2):
    return num1 + num2

def subtract(num1, num2):
    return num1 - num2

def multiply(num1, num2):
    return num1 * num2

def divide(num1, num2):
    if (num1 == 0 or num2 == 0):
        print("\nCannot divide by zero")
        exit()
    return num1 / num2

# Unary Operators
def cosine(num):
    return math.cos(math.radians(num))

def sine(num):
    return math.sin(math.radians(num))

def tan(num):
    return math.tan(math.radians(num))

def exp(num):
    return math.exp(num)

def ln(num):
    if num <=0:
        return "Compute Error"
    return math.log(num)

def sqrt(num):
    return math.sqrt(num)

def sqr(num):
    return num * num

def sqrt3(num):
    return num ** (1/3)

def cube(num):
    return num * num * num

def main():
    pygame.init()
    clock = pygame.time.Clock()
    fps = 60
    customFont = pygame.font.SysFont("comicsans", 25)

    pygame.display.set_caption("Calculator")
    screen = pygame.display.set_mode((460,600))
    background = pygame.Surface(screen.get_size())
    background.fill((49,55,66))

    background = background.convert()
    screen.blit(background, (0, 0))

    SymbolsList = [("exp"), ("ln"), ("sqrt"), ("2^x"), ("sqrt3"),
                    ("7"), ("4"), ("1"), ("0"), ("3^x"),
                    ("8"), ("5"), ("2"), ("."), ("cos"),
                    ("9"), ("6"), ("3"), ("+/-"), ("sin"),
                    ("/"), ("*"), ("-"), ("+"), ("tan")]

    pygame.draw.rect(screen, (255,255,255), (30,25,400,40))
    
    basePosW = 25
    basePosH = 100

    # Loop to create a grid of buttons
    i = 0
    for x in SymbolsList:
        basePosH = basePosH+80
        pygame.draw.rect(screen, (130,130,130), (basePosW,basePosH,60,40))
        button = pygame.Rect(basePosW,basePosH,60,40)
        buttonText = customFont.render(x, 1, (255,255,255))
        
        # Update the screen to include the text
        screen.blit(buttonText, (basePosW+8, basePosH+10))
        
        i+=1
        if i == 5:
            i = 0
            basePosH = 100
            basePosW += 85 
    
    basePosW = 25
    basePosH = 100

    # C/Clear
    pygame.draw.rect(screen, (130,130,130), (25,100,60,40))
    buttonText = customFont.render("Clear", True, (250, 250, 255))
    screen.blit(buttonText, (basePosW+8, basePosH+10))
                            #((rgb), x1, y1, width, height)

    # AC/Cancel
    pygame.draw.rect(screen, (130,130,130), (125,100,115,40))
    buttonText = customFont.render("Cancel", 1, (255, 255, 255))
    screen.blit(buttonText, (125+30, basePosH+10))
    
    # Ok/=
    pygame.draw.rect(screen, (130,130,130), (295,100,115,40))
    buttonText = customFont.render("=", 1, (255, 255, 255))
    screen.blit(buttonText, (295+50, basePosH+10))
    
    running = False
    while running:
    # event handling, gets all event from the event queue
        for event in pygame.event.get():
        # only do something if the event is of type QUIT
            if event.type == pygame.QUIT:
                running = False
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    running = False # user pressed ESC
            # gets mouse position
            if event.type == pygame.MOUSEBUTTONDOWN:
                mouse_pos = event.pos
                if button.collidepoint(mouse_pos):
                    print("Button pressed at {0}".format(mouse_pos)) 
    pygame.display.update()
    clock.tick(fps)

    num1 = float(input("Enter a number: "))
    op = input("Choose an operator + - * / cos sin tan exp ln sqrt sqr sqrt3 cube: ")
    
    if (op == "+" or op == "-" or op == "*" or op == "/"):
        num2 = float(input("Enter another number: "))
    print("")

    # Binary operators
    if op == "+":
        print("{} {} {} = {}".format(num1, op, num2, add(num1, num2))),
    elif op == "-":
        print("{} {} {} = {}".format(num1, op, num2, subtract(num1, num2))),
    elif op == "*":
       print("{} {} {} = {}".format(num1, op, num2, multiply(num1, num2))),
    elif op == "/":
        print("{} {} {} = {}".format(num1, op, num2, divide(num1, num2))),
    
    # Unary operators
    elif op == "cos":
        print("{} Result = {}".format(op, cosine(num1)))
    elif op == "sin":
        print("{} Result = {}".format(op, sine(num1)))
    elif op == "tan":
        print("{} Result = {}".format(op, tan(num1)))
    elif op == "exp":
        print("{} Result = {}".format(op, exp(num1)))
    elif op == "ln":
        print("{} Result = {}".format(op, ln(num1)))
    elif op == "sqrt":
        print("{} Result = {}".format(op, sqrt(num1)))
    elif op == "sqr":
        print("{} Result = {}".format(op, sqr(num1)))
    elif op == "sqrt3":
        print("{} Result = {}".format(op, sqrt3(num1)))
    elif op == "cube":
        print("{} Result = {}".format(op, cube(num1)))
    else:
        print("Invalid operator")

if __name__ == '__main__':
    main()