'''
Name: Rodrigo Ortiz
Course: CMPS 3500
Date: 5/7/2020
Description: Scientific Calculator in Python: Final Project
'''

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