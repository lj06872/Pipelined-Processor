
addi x10, x0, 0x100
addi x14, x0, 15
sw x14, 0(x10)
addi x14, x0, 83
sw x14, 4(x10)
addi x14, x0, 6
sw x14, 8(x10)
addi x11, x0, 3

beq x0,x0,selectionSort
return: beq x0,x0, END

#selection sort
selectionSort:
#x10 : base address of array
#x11 : len(array)

addi x6, x0, 0 #i
add x7, x0, x11 #stop i
addi x28, x0, 0 #j
add x29, x0, x11 #stop j
blt x6, x7, Fori
beq x0,x0, EndFori
addi x30, x0,0 #stores memory address based on data type

Fori:
  slli x30, x6, 2 #shifting by 2 bcs it’s a word array
  add x30,x30,x10
  lw x18, 0(x30)
  add x28,x0,x6 # j = i
  blt x28, x29, Forj #--> change
  beq x0,x0, EndForj
  addi x31, x0,0

Forj:
slli x31,x28,2
add x31,x31,x10
lw x19, 0(x31)
blt x19,x18, IF #--> change
beq x0,x0, ENDIF

IF:
sw x19, 0(x30)
sw x18, 0(x31)
beq x0,x0,ENDIF

ENDIF:
addi x28,x28,1
blt x28,x29, Forj

EndForj:
addi x6, x6, 1
blt x6,x7,Fori

EndFori:
beq x0,x0,return

END:







 


 
