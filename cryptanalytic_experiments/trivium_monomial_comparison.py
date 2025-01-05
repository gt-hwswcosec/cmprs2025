# Basic constructs:
from ProductRegisters.FeedbackRegister import FeedbackRegister
from ProductRegisters.FeedbackFunctions import *

# Boolean logic and chaining templates
from ProductRegisters.BooleanLogic import *
from ProductRegisters.BooleanLogic.ChainingGeneration.Templates import *
import ProductRegisters.BooleanLogic.ChainingGeneration.TemplateBuilding

# Berlekamp-Massey and variants
from ProductRegisters.Tools.RegisterSynthesis.lfsrSynthesis import *
from ProductRegisters.Tools.RegisterSynthesis.fcsrSynthesis import *
from ProductRegisters.Tools.RegisterSynthesis.nlfsrSynthesis import *

# Tools and other extraneous files
import ProductRegisters.Tools.ResolventSolving as ResolventSolving
from ProductRegisters.Tools.RootCounting.MonomialProfile import *

# Cryptanalysis:
from ProductRegisters.Cryptanalysis.cube_attacks import *
from ProductRegisters.Cryptanalysis.utility import *

# Other
import matplotlib.pyplot as plt
import csv

num_cycles = 320
degrees = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7]
num_mons = [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 23, 23, 23, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 29, 32, 44, 48, 48, 48, 51, 51, 51, 51, 51, 51, 52, 55, 67, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 74, 98, 100, 100, 100, 101, 101, 101, 101, 101, 101, 101, 101, 101, 101, 101, 101, 101, 104, 116, 117, 117, 117, 120, 120, 120, 126, 129, 139, 138, 138, 138, 138, 138, 138, 138, 138, 138, 144, 159, 192, 195, 195, 195, 195, 195, 195, 196, 196, 196, 197, 233, 294, 294, 315, 345, 345, 345, 345, 345, 348, 360, 361, 364, 406, 550, 715, 790, 793, 826, 871, 869, 869, 869, 869, 869, 869, 869, 872, 884, 885, 885, 906, 1007, 1133, 1209, 1210, 1279, 1357, 1356, 1356, 1356, 1353, 1353, 1383, 1529, 1710, 1801, 1802, 1802, 1802, 1802, 1802, 1802, 1807, 1898, 2010, 2008, 2089, 2250, 2634, 3021, 3142, 3146, 3215, 3289, 3288, 3414, 3550, 3552, 3727, 3939, 3939, 4038, 4147, 4147, 4162, 4183, 4181, 4297, 4790, 5699, 6322, 7161, 9041, 10580, 11138, 11142, 11395, 11658, 11657, 11660, 12030, 13815, 15399, 15584]
C17_monomials = []
C17_degrees = []

with open("monomial_data.csv", mode="r") as file:
    reader = csv.reader(file)
    for i, row in enumerate(reader):
        if (i >= 320):
            break
        a, b, c = row
        C17_monomials.append(int(b))
        C17_degrees.append(int(c))

plt.title("Number of Monomials in Keystream Equation")
plt.xlabel("Clock Cycle")
plt.ylabel("Number of Monomials")
plt.scatter(range(num_cycles),C17_monomials, label='17-bit CMPR')
plt.scatter(range(num_cycles),num_mons, label="Trivium")
plt.legend(loc="upper left")
plt.show()

plt.title("Degree of Keystream Equation")
plt.xlabel("Clock Cycle")
plt.ylabel("Degree")
plt.scatter(range(num_cycles),C17_degrees, label='17-bit CMPR')
plt.scatter(range(num_cycles),degrees, label="Trivium")
plt.legend(loc="lower right")
plt.show()
