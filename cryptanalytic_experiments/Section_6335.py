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
F = FeedbackRegister.from_file('C170_stored.json')
F.fn.compile()

def cmprtrivium_v3(key, iv, keystream_length):
    initrounds = 100
    initstate_iv = str2list(iv)
    initstate = str2list(key)
    if (len(key) != 84):
        print("Key must be 84 bits.")
        quit()
    if (len(iv) != 84):
        print("IV must be 84 bits.")
        quit()

    if (any(x != '0' and x != '1' for x in key) | any(x != '0' and x != '1' for x in iv)):
        print("Key and IV must be in binary format (base 2).")
        quit()
    
    # When using F.seed(val), the ith bit of val indicates the ith bit of the CMPR at t=0 (initial state)
    # So the seeding goes from LSB -> MSB, left-to-right
    F.seed([1]*2 + initstate_iv + initstate)

    F.reset()
    keystream = ""

    for _ in range(initrounds):
        F.clock_compiled()

    # Uncomment the section below and comment the two lines above to observe state-swapping fix the distinguisher
    
    # for _ in range(initrounds//2):
    #     F.clock_compiled()

    # swap_state(F)

    # for _ in range(initrounds//2):
    #     F.clock_compiled()

    for state in F.run_compiled(keystream_length):
        keystream += str(state[0] ^ state[3] ^ state[7])
    return keystream

filein = open('./distinguisher_ivs.txt', 'r')
fileout = open('./keystreams.txt', 'w')
lines = filein.readlines()
key = generate_random_binary(84) # fixed key
j = 1
for line in lines:
    iv = line.strip()
    keystream = cmprtrivium_v3(key, iv, 128)
    fileout.write(keystream + '\n')
    print("Keystream #" + str(j) + " generated.")
    j += 1
filein.close()
fileout.close()

filein_keystreams = open('./keystreams.txt', 'r')
lines_keystreams = filein_keystreams.readlines()
xor_result = '0'*128
for individual_keystream in lines_keystreams:
    # XOR all of the generated keystreams (equivalent to summing over a cube)
    xor_result = ''.join('1' if b1 != b2 else '0' for b1, b2 in zip(xor_result, individual_keystream.strip()))

print(xor_result)

# For indistinguishability, we expect num_ones and num_zeros to be roughly the same (with some variation)
num_ones = xor_result.count('1')
num_zeros = xor_result.count('0')

print(f"Number of 1's: {num_ones}")
print(f"Number of 0's: {num_zeros}")
