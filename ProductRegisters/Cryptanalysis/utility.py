# Basic constructs:
from ProductRegisters.FeedbackRegister import FeedbackRegister
from ProductRegisters.FeedbackFunctions import *

# Other
import secrets
import re

# Divide an n-bit binary string into blocks of a specified size
# Supports padding if valid padding is provided (single character or appropriate size string (size of divisor of remaining bits)), otherwise len(msg) must be multiple of block_size
def divide_into_blocks(block_size, msg, padding=None):
    if (padding == None and len(msg) % block_size != 0):
        raise ValueError("Message length must be a multiple of block size.")
    elif (padding != None and (block_size - (len(msg) % block_size)) % len(padding) != 0):
        raise ValueError("Padding must be either one bit or of a length that is a divisor of the number of the unfilled bits of the last block.")
    
    if (padding != None and len(msg) % block_size != 0):
        msg = msg + padding * ((block_size - (len(msg) % block_size)) // len(padding))

    num_blocks = len(msg) // block_size

    return [msg[i * block_size: (i + 1) * block_size] for i in range(num_blocks)]


# Generate a pseudorandom binary string of length n
def generate_random_binary(n):
    if (type(n) != int):
        raise TypeError("Function input must be positive integer.")
    if (n <= 0):
        raise ValueError("Function input must be positive integer.")
    random_int = secrets.randbelow(2**n)
    random_binary = bin(random_int)[2:].zfill(n)

    return random_binary

# Convert a string to an integer list
def str2list(s):
    if (type(s) != str and type(s) != FeedbackRegister):
        raise TypeError("Function input must be string or FeedbackRegister.")
    
    return list(map(int, [*s]))

def list_to_polynomial_str(binary_list):
    terms = []
    for i, bit in enumerate(binary_list):
        if bit == 1:
            if i == 0:
                terms.append("1")
            elif i == 1:
                terms.append("x")
            else:
                terms.append(f"x^{i}")
    
    return " + ".join(terms) if terms else "0"

# Convert an integer list to a string
def list2str(l):
    if (type(l) != list):
        raise TypeError("Function input must be list.")
    
    return ''.join([str(elem) for elem in l])

# Swap the lower and upper halves of a FeedbackRegister object's state
# Also resets the register so it starts clocking at state zero
def swap_state(F:FeedbackRegister, odd_behavior=None, swap_blocks=2, orientation="steady"):
    """
    odd_behavior: None, MS (most significant), LS (least significant), pivot
    swap_blocks: int > 1 AND EVEN
    orientatation: "steady", "flip"

    Suggested Config: 
        odd_behavior: MS or LS for max movement of values, else pivot is nice/easy to understand
        orientation: steady
        swap_blocks: as needed


    Tips:
    Keep swap_blocks <= F.size // 2
    Can reverse entire state by: swap_blocks==f.size, steady, none
    Currently orientation="steady" is the only useful behavior (flip reverses the entire state in almost all circumstances), but flip will be useful if the way we swap changes later. 
    """
    if (type(F) != FeedbackRegister):
        raise TypeError("Function input must be FeedbackRegister object.")
    
    # For compatibility and safety:

    # TODO: remove this portion once the more complex function later below is verified as correctly behaving
    # Below is original function, running for default case
    if (odd_behavior==None and swap_blocks==2 and orientation=="steady"):
        n = F.size
        #n = len(F)
        if (n % 2 != 0):
            raise ValueError("Register size must be even.")
        state = list(map(int, [*F]))
        F.seed(state[-n//2:] + state[:n//2])
        F.reset()
        
        return

    # --------------------------

    if (odd_behavior != None and odd_behavior != "MS" and odd_behavior != "LS" and odd_behavior != "pivot"):
        raise ValueError("Odd-behavior must be either None, 'MS', 'LS', or 'pivot'.")
    if (type(swap_blocks) != int):
        raise TypeError("swap_blocks must be an int.")
    if (swap_blocks <= 1 or swap_blocks % 2 != 0):
        raise ValueError("swap_blocks must be greater than 1 and even.")
    if (orientation != "steady" and orientation != "flip"):
        raise ValueError("orientation must be either 'steady' or 'flip'")
    
    n = F.size
    #n = len(F)
    block_size = n // swap_blocks
    block_remainder = n % swap_blocks

    if (n % swap_blocks != 0 and odd_behavior == None):
        raise ValueError("Register size must be divisible by swap_blocks, or else odd_behavior must be specified.")
    state = list(map(int, [*F]))

    new_state = []
    start = []
    end = []

    for i in range(0,swap_blocks):
        adjust = 0
        if (i == (swap_blocks // 2) - 1) or (i == swap_blocks // 2):
            adjust = block_remainder // 2
            if block_remainder % 2 == 1:
                if odd_behavior == "MS" and ((i == swap_blocks // 2) - 1): # MS is taken to be lower indexes here
                    adjust += 1
                elif odd_behavior == "LS" and (i == swap_blocks // 2): # LS is taken to be higher indexes here
                    adjust += 1
                elif odd_behavior == "pivot" and (i == swap_blocks // 2):
                    start.append(end[-1])
                    end.append(end[-1] + 1)

        if len(start) == 0:
            start = [0]
            end = [block_size + adjust]
        else:
            start.append(end[-1])
            end.append(end[-1] + block_size + adjust)

    for i in reversed(range(len(start))):
        new_state += _partition_and_orient(state, start[i], end[i], orientation)

    F.seed(new_state)
    F.reset()
    return

def _partition_and_orient(state, start_incl, end_excl, orientation):
    
    if (orientation != "steady" and orientation != "flip"):
        raise ValueError("orientation must be either 'steady' or 'flip'")
    
    part = state[start_incl: end_excl]
    
    if orientation=="flip":
        part.reverse()
        
    return part


# Takes as input a polynomial string and the desired length of the output list
# Returns a list of 0's and 1's representing the polynomial (binary representation)
# the zero position (leftmost element) of the list corresponds to the constant term of the polynomial
# the rightmost element of the list corresponds to the highest degree term of the polynomial
# Useful for setting the update and primitive polynomials of an MPR more easily
def poly(polynomial_str):
    if type(polynomial_str) != str:
        raise TypeError("Function input must be string.")
    
    polynomial_str = polynomial_str.replace(" ", "")
    
    terms = re.split(r'(?=\+|\-)', polynomial_str)
    
    degree = 0
    for term in terms:
        if "x^" in term:
            power = int(term.split("^")[1])
            degree = max(degree, power)
        elif "x" in term and "^" not in term:
            degree = max(degree, 1)
    
    coefficients = [0] * (degree + 1)
    
    for term in terms:
        term = term.replace('+', '')
        if term == "1":
            coefficients[0] = 1
        elif term == "x":
            coefficients[1] = 1
        elif "x^" in term:
            power = int(term.split("^")[1])
            coefficients[power] = 1

    return coefficients
