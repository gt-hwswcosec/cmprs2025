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

# MPR and CMPR instantiation
M7 = MPR(7, poly("1 + x + x^7"), poly("1 + x^5"))

M5 = MPR(5, poly("1 + x^2 + x^5"), poly("1 + x + x^4"))

M3 = MPR(3, poly("1 + x + x^3"), poly("1 + x^2"))

M2 = MPR(2, poly("1 + x + x^2"), poly("1 + x"))

C17 = CMPR([M7,M5,M3,M2])
# Create deliberately weak chaining functions, comment/uncomment as needed
C17[0].add_arguments(BooleanFunction.construct_ANF( [ True, [6], [2, 3, 7, 13] ] )) # Observe that this chaining function contains a bit from the largest MPR (weakness)
C17[1].add_arguments(BooleanFunction.construct_ANF( [ [2], [3], [4, 9, 11, 14] ] ))
C17[2].add_arguments(BooleanFunction.construct_ANF( [ True, [10], [5, 7, 11, 15] ] ))
C17[3].add_arguments(BooleanFunction.construct_ANF( [ [5], [7], [8, 9, 14, 15] ] ))
C17[4].add_arguments(BooleanFunction.construct_ANF( [ [11], [13], [6, 7, 10, 16] ] ))
C17[5].add_arguments(BooleanFunction.construct_ANF( [ True, [14], [10, 11, 12, 13] ] ))
C17[7].add_arguments(BooleanFunction.construct_ANF( [ [10], [15], [11, 12, 13, 14] ] ))
C17[8].add_arguments(BooleanFunction.construct_ANF( [ True, [10], [11, 12, 14, 16] ] ))
C17[9].add_arguments(BooleanFunction.construct_ANF( [ [11], [12], [13, 14, 15, 16] ] ))
# Uncomment the line below to generate strong chaining that "fixes" cube attacks
#C17.generateChaining(template=old_ANF_template(max_and=4, max_xor=3))
C17.compile()
F = FeedbackRegister(2**C17.size-1,C17)
F.clock_compiled()
F.reset()

# Initialization Rounds (number of times the CMPR is clocked before generating output bits)
num_init_rounds = 100
# Keystream Length (number of times the CMPR is clocked after initialization, AKA number of output bits)
keystream_length = 100

# for the situation where  the CMPR is initialized to (key : IV : fixed bits) or a permutation thereof:
# in this example:
# the 2 LSBs (2-bit MPR) are initialized to constant values
# the next 9 bits are the IV, which can be tweaked during the cube attack
# the 7 MSBs (7-bit MPR) are the secret key, which cannot be tweaked during the cube attack
IV_start = 2 # Where in the CMPR initial state the IV starts (zero-indexed)
key_start = 10 # Where in the CMPR initial state the key starts (zero-indexed)
tweakable_bits = list(range(IV_start,key_start))
known_bits = list(range(key_start))

# Bits of the initial state that can be tweaked by the user AND are public (IV)
print("tweakable bits: ", tweakable_bits)
# Bits of the initial state that are known to the user but not necessarily (IV, fixed bits)
print("known bits: ", known_bits)

# Output function defined as a boolean function of the CMPR bits, in this example it is bit 0
# Examples of other output functions: XOR(VAR(0), VAR(1)) corresponds to bit 0 XOR bit 1
# XOR(AND(VAR(0), VAR(1)), VAR(2)) corresponds to (bit 0 AND bit 1) XOR bit 2
output_function = VAR(0)

# From the output function, obtain and print the general form of the output polynomial in terms of the CMPR bits (AKA the output profile)
# This is not the *exact* output polynomial but shows its general form
# Will look something like <> + <3:1/2> + <2:1/3> + <0:7/7, 1:2/5, 2:1/3> + <0:3/7, 1:3/5, 2:1/3> + <0:7/7, 2:1/3> + <0:1/7, 1:1/5, 2:2/3> + <0:5/7, 2:2/3> + <1:1/5> + <0:7/7, 1:4/5> + <0:5/7, 1:5/5> + <0:7/7>
# <> denotes a constant factor of 1
# <a:b/c> denotes "1 up to b" variables from the "a"th MPR in the CMPR (where 0 corresponds to the largest MPR). "c" denotes the size of the "a"th MPR.
output_profile = output_function.remap_constants({
    0: MonomialProfile.logical_zero(),
    1: MonomialProfile.logical_one()
}).eval_ANF(C17.monomial_profiles())

print("Output Profile:" + str(output_profile))

cmpr_cube_summary(C17,output_function,tweakable_bits,True)

access_fn,sim_fn,test_fn = access_fns(
    register = F,
    output_fn = output_function,
    tweakable_bits = tweakable_bits,
    init_rounds=num_init_rounds,
    keystream_len= keystream_length
)

print("Offline Phase:")
cube_data = cmpr_cube_attack_offline(
    cmpr_fn = C17,
    output_fn = output_function,
    sim_fn = sim_fn,
    tweakable_vars = tweakable_bits,
    time_limit = 600,
    num_tests = 20,
    verbose = True
)

print("Online Phase:")

# initialize the CMPR
# the goal is to see whether the attack can recover the seed
seed = [1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1]
F.seed(seed)
F.reset()

known_values = {idx:F[idx] for idx in known_bits}

access_fn,sim_fn,test_fn = access_fns(
    register = F,
    output_fn = output_function,
    tweakable_bits = tweakable_bits,
    init_rounds = num_init_rounds,
    keystream_len = keystream_length
)

init_state = cube_attack_online(
    access_fn = access_fn,
    test_fn = test_fn,
    state_size = F.size,
    known_bits = known_values,
    cube_data = cube_data,
    verbose = True
)

print(F._state)
print(init_state)
print("Correct: ", np.all(F._state == init_state))
print('\n')
