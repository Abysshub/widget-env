import os

def main(message):
    with open("output/result.txt", "w") as file:
        file.write(message)

main("Success")
