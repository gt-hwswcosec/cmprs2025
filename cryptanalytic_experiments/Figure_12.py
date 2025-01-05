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

# Helper Functions

def num_monomials(anf):
    return len(anf.args)

def degree(anf):
    deg = 0
    for term in anf.args:
        if type(term) != CONST:
            deg = max(deg,len(term.args))
    return deg

num_cycles = 16
degrees = []
num_mons = []

M7 = MPR(7, poly("1 + x + x^2 + x^3 + x^7"), poly("x"))

M5 = MPR(5, poly("1 + x^2 + x^3 + x^4 + x^5"), poly("x"))

M3 = MPR(3, poly("1 + x + x^3"), poly("x"))

M2 = MPR(2, poly("1 + x + x^2"), poly("x"))

C17 = CMPR([M7, M5, M3, M2])

C17[0].add_arguments(BooleanFunction.construct_ANF( [ True, [6], [2, 3, 7, 13] ] ))
C17[1].add_arguments(BooleanFunction.construct_ANF( [ [2], [3], [4, 9, 11, 14] ] ))
C17[2].add_arguments(BooleanFunction.construct_ANF( [ True, [10], [5, 7, 11, 15] ] ))
C17[3].add_arguments(BooleanFunction.construct_ANF( [ [5], [7], [8, 9, 14, 15] ] ))
C17[4].add_arguments(BooleanFunction.construct_ANF( [ [11], [13], [6, 7, 10, 16] ] ))
C17[5].add_arguments(BooleanFunction.construct_ANF( [ True, [14], [10, 11, 12, 13] ] ))
C17[7].add_arguments(BooleanFunction.construct_ANF( [ [10], [15], [11, 12, 13, 14] ] ))
C17[8].add_arguments(BooleanFunction.construct_ANF( [ True, [10], [11, 12, 14, 16] ] ))
C17[9].add_arguments(BooleanFunction.construct_ANF( [ [11], [12], [13, 14, 15, 16] ] ))

C17.compile()

for i,anfs in enumerate(C17.anf_iterator(num_cycles,bits = [0])):
    if i == 0:
        continue

    print(f"Clock {i} -- Number of Monomials: {num_monomials(anfs[0])}, Degree: {degree(anfs[0])}")
    degrees.append(degree(anfs[0]))
    num_mons.append(num_monomials(anfs[0]))
