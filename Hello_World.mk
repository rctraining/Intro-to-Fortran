
# use this compiler for the .f90 --> .o step

FC=gfortran -c

# use these options to the compiler

FFLAGS=-std=f2008ts -Wall -fcheck=all -finit-real=nan

# use the compiler driver for the .o --> a.out step

LD=gfortran

# use these options to the linker

LDFLAGS=

# the names of the object files

OBJS=Speaker.o Speak.o Personal_Library.o Write_Identifier.o Hello_World.o

# make this executable

Hello_World: ${OBJS}
	${LD} ${LDFLAGS} ${OBJS} -o Hello_World

# make this object file

Speaker.o: Speaker.f90
	${FC} ${FFLAGS} Speaker.f90

# make this object file

Speak.o: Speak.f90
	${FC} ${FFLAGS} Speak.f90

# make this object file

Personal_Library.o: Personal_Library.f90
	${FC} ${FFLAGS} Personal_Library.f90

# make this object file

Write_Identifier.o: Write_Identifier.f90
	${FC} ${FFLAGS} Write_Identifier.f90

# make this object file

Hello_World.o: Hello_World.f90
	${FC} ${FFLAGS} Hello_World.f90

