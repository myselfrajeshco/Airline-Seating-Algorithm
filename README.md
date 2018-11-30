# Airline-Seating-Algorithm
A Ruby program to arrange the seating for the Airline Passengers

A program that helps to allocate seats to the passengers in a flight based on the following input and rules.

Rules for seating:

• Always seat passengers starting from the front row to back, starting from the left to the right
• Fill aisle seats first followed by window seats followed by center seats (any order in center seats)

Input to the program will be:

• a 2D array that represents the rows and columns [[3,4], [4,5], [2,3], [3,4]]. This 2D array is just an example. The input to the program will be a dynamic 2D array.
• Number of passengers waiting in queue.


See below for an example input and the respective seating arrangement based on the input.

A 2D array that represents the rows and columns [[3,2], [4,3], [2,3], [3,4]] (Please see the attached PDF document - 'Seating_2D_array.pdf')

If there were 30 passengers from then the seating output will be as in the attachment 'Seating_Result.pdf'

Below are the points to be noted:

1. The Logic / Data structure / Algorithm used to successfully complete the programming challenge
2. The elegance of the code, modularity and readability
3. A VISUAL output that is printed (on the screen, in a console or exported to a file etc.) in way that is easy to read, identify the aisle, middle and window rows and has clear seating plan and passenger number.
4. Testability, TDD and test cases
