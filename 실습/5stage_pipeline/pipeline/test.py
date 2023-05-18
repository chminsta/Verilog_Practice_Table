
def make_bits(a, b):
    # Convert b to an integer
    b = int(b)
    
    # Check if b is negative
    if b < 0:
        # Calculate 2's complement of b
        b = (1 << a) + b

    # Convert b to binary representation with a bits
    binary = format(b, '0' + str(a) + 'b')
    
    return binary

print(make_bits(5,"2"))
print(make_bits(8,"-5"))
