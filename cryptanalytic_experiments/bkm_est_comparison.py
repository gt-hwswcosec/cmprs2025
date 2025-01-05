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
from ProductRegisters.Tools.MersenneTools import mersenne_combinations
from ProductRegisters.Tools.RegisterSynthesis.lfsrSynthesis import berlekamp_massey
import random

# MPRs
M127 = MPR(127, poly("1 + x^13 + x^45 + x^54 + x^127"), poly("x"))

M107 = MPR(107, poly("1 + x^23 + x^29 + x^40 + x^84 + x^89 + x^107"), poly("x"))

M89 = MPR(89, poly("1 + x^18 + x^21 + x^31 + x^68 + x^81 + x^89"), poly("x"))

M61 = MPR(61, poly("1 + x^15 + x^19 + x^44 + x^61"), poly("x"))

M31 = MPR(31, poly("1 + x + x^2 + x^3 + x^31"), poly("x"))

M19 = MPR(19, poly("1 + x + x^2 + x^3 + x^4 + x^5 + x^19"), poly("x"))

M17 = MPR(17, poly("1 + x^3 + x^4 + x^6 + x^7 + x^8 + x^17"), poly("x"))

M13 = MPR(13, poly("1 + x^3 + x^5 + x^9 + x^11 + x^12 + x^13"), poly("x"))

M7 = MPR(7, poly("1 + x + x^2 + x^3 + x^7"), poly("x"))

M5 = MPR(5, poly("1 + x^2 + x^3 + x^4 + x^5"), poly("x"))

M3 = MPR(3, poly("1 + x + x^3"), poly("x"))

M2 = MPR(2, poly("1 + x + x^2"), poly("x"))

mpr_map = {
    2:M2, 3:M3, 5:M5, 7:M7, 13:M13,
    17:M17, 19:M19, 31:M31, 61:M61, 89:M89,
    107:M107, 127:M127
}

num_trials = 400 # Run both tests many times to avoid BKM short cycles -- RUNTIME BOTTLENECK

for solution_group in mersenne_combinations(range(20)): # Test CMPRs of size up to size 20
    for config, epr in solution_group[1]: # Specific CMPR configuration
        if len(config) > 1: # Only test configurations with >1 MPR
            print(config)                
            C = CMPR([mpr_map[i] for i in config[::-1]])
            C.generateChaining(template=old_ANF_template(max_and=4, max_xor=4))
            C.compile()
            alg_inaccurate = 0
            actual_trials = 0
            while actual_trials < num_trials:
                print("Trial:" + str(actual_trials))
                F = FeedbackRegister(random.randint(1, 2**C.size - 1), C)
                # Estimation Algorithm
                L, U = C.estimate_LC(0)
                # Berlekamp-Massey
                seq = [state[0] for state in F.run_compiled(2*U + 1000)]
                linear_complexity, feedback_polynomial = berlekamp_massey(seq) 
                if not(L <= linear_complexity <= U) and (F.period_compiled() == C.max_period): # BKM result not in estimate interval and no short cycle?
                    alg_inaccurate += 1
                if F.period_compiled() == C.max_period: # Proceed to the next test only if no short cycle
                    actual_trials += 1
            print("Probability that Estimation Algorithm is Correct: " + str(1 - (alg_inaccurate/num_trials))) # Accuracy        
