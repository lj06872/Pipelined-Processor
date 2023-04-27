
addi x10, x0, 0x000
addi x14, x0, 15
sd x14, 0(x10)
addi x14, x0, 83
sd x14, 8(x10)
addi x14, x0, 6
sd x14, 16(x10)
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
  slli x30, x6, 3 #multiplying by 8, since array is of type doubleword
  add x30,x30,x10
  ld x18, 0(x30)
  add x28,x0,x6 # j = i
  blt x28, x29, Forj #--> change
  beq x0,x0, EndForj
  addi x31, x0,0

Forj:
slli x31,x28, 3
add x31,x31,x10
ld x19, 0(x31)
ld x18, 0(x30)
blt x19,x18, IF #--> change
beq x0,x0, ENDIF

IF:
sd x19, 0(x30)
sd x18, 0(x31)
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
