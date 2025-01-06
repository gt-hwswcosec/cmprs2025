# (c) 2025 Georgia Institute of Technology
# This code is licensed under the MIT license (see LICENSE for details)

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

# small helper functions:
def num_monomials(anf):
    return len(anf.args)

def degree(anf):
    deg = 0
    for term in anf.args:
        if type(term) != CONST:
            deg = max(deg,len(term.args))
    return deg

# MPR and CMPR instantiation
M7 = MPR(7, poly("1 + x + x^7"), poly("1 + x^5"))

M5 = MPR(5, poly("1 + x^2 + x^5"), poly("1 + x + x^4"))

M3 = MPR(3, poly("1 + x + x^3"), poly("1 + x^2"))

M2 = MPR(2, poly("1 + x + x^2"), poly("1 + x"))

C17 = CMPR([M7,M5,M3,M2])

C17[0].add_arguments(BooleanFunction.construct_ANF( [ True, [6], [2, 3, 7, 13] ] )) # Observe that this chaining function contains a bit from the largest MPR (weakness)
C17[1].add_arguments(BooleanFunction.construct_ANF( [ [2], [3], [4, 9, 11, 14] ] ))
C17[2].add_arguments(BooleanFunction.construct_ANF( [ True, [10], [5, 7, 11, 15] ] ))
C17[3].add_arguments(BooleanFunction.construct_ANF( [ [5], [7], [8, 9, 14, 15] ] ))
C17[4].add_arguments(BooleanFunction.construct_ANF( [ [11], [13], [6, 7, 10, 16] ] ))
C17[5].add_arguments(BooleanFunction.construct_ANF( [ True, [14], [10, 11, 12, 13] ] ))
C17[7].add_arguments(BooleanFunction.construct_ANF( [ [10], [15], [11, 12, 13, 14] ] ))
C17[8].add_arguments(BooleanFunction.construct_ANF( [ True, [10], [11, 12, 14, 16] ] ))
C17[9].add_arguments(BooleanFunction.construct_ANF( [ [11], [12], [13, 14, 15, 16] ] ))

C17.compile()

# TRIVIUM definitions: https://www.ecrypt.eu.org/stream/p3ciphers/trivium/trivium_p3.pdf
t1 = XOR(VAR(65),VAR(92))
t2 = XOR(VAR(161),VAR(176))
t3 = XOR(VAR(242),VAR(287))

t1 = XOR(t1,AND(VAR(90),VAR(91)),VAR(170))
t2 = XOR(t2,AND(VAR(174),VAR(175)),VAR(263))
t3 = XOR(t3,AND(VAR(285),VAR(286)),VAR(68))

updates = ([t3] + [VAR(i) for i in range(92)]     # bits 0-92      (93 total)
        + [t1] + [VAR(i) for i in range(93,176)]  # bits 93-176    (84 total)
        + [t2] + [VAR(i) for i in range(177,287)] # bits 177-287  (111 total)
)

trivium_update = FeedbackFunction(updates)
trivium_update.compile()

# using the same CMPR from the paper to replicate the graphs:
T = trivium_update
trivium_output = XOR(VAR(65), VAR(92), VAR(161), VAR(176), VAR(242), VAR(287))
necessary_bits = trivium_output.idxs_used()
print("Calculating ANFs for bits: ", necessary_bits)

# tracking statistics
num_cycles = 320
degrees = []
num_mons = []

# main loop
print("printing disabled due to large number of iterations, look at the graph instead")
for i,anfs in enumerate(T.anf_iterator(num_cycles,bits = necessary_bits)):
    # at time step zero, the functions are just VAR(bit). This is fine, but our helper functions
    # arent compatible with this format. A more full implementation could fix this, but we can just
    # skip this first cycle - it doesnt contain much useful information anyway.
    if i == 0:
        continue

    output_anf = trivium_output.compose(anfs).translate_ANF()

    degrees.append(degree(output_anf))
    num_mons.append(num_monomials(output_anf))

# now compute degrees and number of monomials for 17-bit CMPR

num_cycles = 17
degrees_C17 = []
num_mons_C17 = []

for i,anfs in enumerate(C17.anf_iterator(num_cycles,bits = [0])):
    if i == 0:
        continue

    degrees_C17.append(degree(anfs[0]))
    num_mons_C17.append(num_monomials(anfs[0]))

# extend the CMPR data using a statistical model
C17_extra = list(np.random.normal(loc = 6257.5, scale = 55.9352304008842, size = 304))

plt.title("Number of Monomials in Keystream Polynomial")
plt.xlabel("Initialization Rounds")
plt.ylabel("Number of Monomials")
plt.scatter(range(len(num_mons_C17)),num_mons_C17, label='17-bit CMPR data')
plt.scatter(range(len(num_mons_C17),len(num_mons_C17)+len(C17_extra)),C17_extra, label='17-bit CMPR Statistical Model')
plt.scatter(range(num_cycles),num_mons, label="TRIVIUM")
plt.legend(loc="upper left")
plt.show()

plt.title("Degree of Monomials in Keystream Polynomial")
plt.xlabel("Initialization Rounds")
plt.ylabel("Degree")
plt.scatter(range(num_cycles),degrees_C17, label='17-bit CMPR')
plt.scatter(range(num_cycles),degrees, label="TRIVIUM")
plt.legend(loc="lower right")
plt.show()
