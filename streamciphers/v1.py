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
F = FeedbackRegister.from_file('C288_stored.json')
F.fn.compile()

def cmprcipher_v1(key, iv, keystream_length):
    initrounds = 100
    initstate_iv = str2list(iv)
    initstate = str2list(key)
    if (len(key) != 128):
        print("Key must be 128 bits.")
        quit()
    if (len(iv) != 128):
        print("IV must be 128 bits.")
        quit()

    if (any(x != '0' and x != '1' for x in key) | any(x != '0' and x != '1' for x in iv)):
        print("Key and IV must be in binary format (base 2).")
        quit()
    
    F.seed([1]*32 + initstate_iv + initstate)

    F.reset()
    keystream = ""
  
    for _ in range(initrounds//2):
        F.clock_compiled()

    swap_state(F) # Swap the internal state halfway through the initialization rounds

    for _ in range(initrounds//2):
        F.clock_compiled()

    for state in F.run_compiled(keystream_length):
        keystream += str(state[0] ^ state[3] ^ state[7])
    return keystream
filein = open('./keys.txt', 'r')
fileout = open('./keystreams.txt', 'w')
lines = filein.readlines()
iv = generate_random_binary(128)
j = 1
for line in lines:
    key = line.strip()
    keystream = cmprcipher_v1(key, iv, 128)
    fileout.write(keystream + '\n')
    print("Keystream #" + str(j) + " generated.")
    j += 1
filein.close()
fileout.close()
