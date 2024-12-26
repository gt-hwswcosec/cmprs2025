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

# MPR and CMPR instantiation
M61 = MPR(61, poly("1 + x^15 + x^19 + x^44 + x^61"), poly("x"))

M31 = MPR(31, poly("1 + x + x^2 + x^3 + x^31"), poly("x"))

M19 = MPR(19, poly("1 + x + x^2 + x^5 + x^19"), poly("x"))

M17 = MPR(17, poly("1 + x + x^2 + x^3 + x^17"), poly("x"))

C128 = CMPR([M61, M31, M19, M17])
C128.generateChaining(template=old_ANF_template(max_and=4, max_xor=4))
C128.compile()
F = FeedbackRegister(2**C128.size-1,C128)
seq = [(state[0] ^ state[3]) for state in F.run_compiled(10000)] # Generate 10000 bits of output from the CMPR, with each output bit corresponding to CMPR bit 0 XOR bit 3
linear_complexity, feedback_polynomial = berlekamp_massey(seq)
print("CMPR Output Linear Complexity: ", linear_complexity)
