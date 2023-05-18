file_path = "Verilog_Practice_Table/실습/5stage_pipeline/pipeline/assembly_code.txt"
with open(file_path) as f:
    codes = f.readlines()

opcodes=[]
PC=0

    
        

def make_bits(a: int, b:str) -> str: #b를 a비트로
    # Convert b to an integer
    bb = int(float(b))
    
    # Check if b is negative
    if bb < 0:
        # Calculate 2's complement of b
        bb = (1 << a) + bb

    # Convert b to binary representation with a bits
    binary = format(bb, '0' + str(a) + 'b')
    
    return str(binary)
        


for code in codes:
    if "addi" in code:  #addi $a $b #c
        a=code.split(" ")[1].replace('$', '')
        b=code.split(" ")[2].replace('$', '')
        c=code.split(" ")[3].replace('#', '')
        a_5bit = make_bits(5,a) 
        b_5bit = make_bits(5,b)         
        c_16bit = make_bits(16,c)         
        new_opcode="001000"+b_5bit+a_5bit+c_16bit
        opcodes.append(new_opcode)
    elif "add" in code: #add $a $b $c
        a=code.split(" ")[1].replace('$', '')
        b=code.split(" ")[2].replace('$', '')
        c=code.split(" ")[3].replace('$', '')
        a_5bit = make_bits(5,a) 
        b_5bit = make_bits(5,b)         
        c_5bit = make_bits(5,c)         
        new_opcode="000000"+b_5bit+c_5bit+a_5bit+"00000"+"100000"
        opcodes.append(new_opcode)
    elif "sub" in code: #sub $a $b $c
        a=code.split(" ")[1].replace('$', '')
        b=code.split(" ")[2].replace('$', '')
        c=code.split(" ")[3].replace('$', '')
        a_5bit = make_bits(5,a) 
        b_5bit = make_bits(5,b)         
        c_5bit = make_bits(5,c)         
        new_opcode="000000"+b_5bit+c_5bit+a_5bit+"00000"+"100010"
        opcodes.append(new_opcode)
    elif "lw" in code: #lw $a b($c)
        a=code.split(" ")[1].replace('$', '')
        b=code.split(" ")[2].replace(')', '').split("($")[0]
        c=code.split(" ")[2].replace(')', '').split("($")[1]        
        a_5bit = make_bits(5,a) 
        b_16bit = make_bits(16,b)         
        c_5bit = make_bits(5,c)         
        new_opcode="100011"+c_5bit+a_5bit+b_16bit
        opcodes.append(new_opcode)
    elif "sw" in code: #sw $a b($c)
        a=code.split(" ")[1].replace('$', '')
        b=code.split(" ")[2].replace(')', '').split("($")[0]
        c=code.split(" ")[2].replace(')', '').split("($")[1]        
        a_5bit = make_bits(5,a) 
        b_16bit = make_bits(16,b)         
        c_5bit = make_bits(5,c)         
        new_opcode="101011"+c_5bit+a_5bit+b_16bit
        opcodes.append(new_opcode)
    elif "beq" in code: #beq $a $b #c
        a=code.split(" ")[1].replace('$', '')
        b=code.split(" ")[2].replace('$', '')
        c=code.split(" ")[3].replace('#', '')
        PC+=4 
        cc=str((int(float(c))-PC)/4)
        a_5bit = make_bits(5,a) 
        b_5bit = make_bits(5,b) 
        c_16bit = make_bits(16,cc)         
        new_opcode="000100"+a_5bit+b_5bit+c_16bit
        opcodes.append(new_opcode)
        PC=int(float(c))
        

    else:        #NOP       
        opcodes.append("0"*32)
        
    PC+=4
    
    for i in range(3):
        opcodes.append("0"*32)


with open('instruction.txt', 'w', encoding='UTF-8') as f:
   for op in opcodes:
       hex_value = hex(int(op, 2))  # Convert binary to hexadecimal
       f.write('0x' + hex_value[2:] + '\n')

# with open('instruction_jinkyu.txt','w',encoding='UTF-8') as f:
#     for op in opcodes:
#         f.write(op+'\n')