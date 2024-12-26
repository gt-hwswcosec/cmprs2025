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
import math

# MPR and CMPR instantiation
M61 = MPR(61, poly("1 + x^15 + x^19 + x^44 + x^61"), poly("x"))

M31 = MPR(31, poly("1 + x + x^2 + x^3 + x^31"), poly("x"))

M19 = MPR(19, poly("1 + x + x^2 + x^5 + x^19"), poly("x"))

M17 = MPR(17, poly("1 + x + x^2 + x^3 + x^17"), poly("x"))

C128 = CMPR([M61, M31, M19, M17])
C128.generateChaining(template=old_ANF_template(max_and=4, max_xor=4))
C128.compile()
# Expect the LSB to have high linear complexity
lower, upper = C128.estimate_LC(0)
x_lower = math.log(lower)/math.log(2)
x_upper = math.log(upper)/math.log(2)
print("Predicted Linear Complexity on LSB (2^n form): ", format(x_lower, ".3e"), " to ", format(x_upper, ".3e"))
# Expect the MSB to have lower linear complexity
lower, upper = C128.estimate_LC(127)
x_lower = math.log(lower)/math.log(2)
x_upper = math.log(upper)/math.log(2)
print("Predicted Linear Complexity on MSB (2^n form): ", format(x_lower, ".3e"), " to ", format(x_upper, ".3e"))

