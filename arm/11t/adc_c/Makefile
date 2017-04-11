
CROSS_COMPILE = arm-linux-
CC = $(CROSS_COMPILE)gcc
CC_FLAGS = -c -I ./include
LD = $(CROSS_COMPILE)ld
LD_FLAGS = -Ttext 0x50000000
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJCOPY_FLAGS = -O binary
OBJDUMP = $(CROSS_COMPILE)objdump
OBJDUMP_FLAGS = -D
TARGET = start
OBJECTS = start.o main.o led.o key.o beep.o lib.o


all:	$(OBJECTS)
	$(LD) $(LD_FLAGS) $(OBJECTS) -o $(TARGET)
	$(OBJCOPY) $(OBJCOPY_FLAGS) $(TARGET) $(TARGET).bin
	$(OBJDUMP) $(OBJDUMP_FLAGS) $(TARGET) > $(TARGET).dis
	#arm-linux-gcc -c start.s
	#arm-linux-objdump -D start > start.dis
	#arm-linux-objcopy -O binary start start.bin
	#arm-linux-ld start.o -o start
	mkdir object	
	mv *.o object/

%.o:%.s
	$(CC) $(CC_FLAGS) $^
%.o:%.S
	$(CC) $(CC_FLAGS) $^
%.o:%.c
	$(CC) $(CC_FLAGS) $^


clean:
	rm -rf *.o start start.bin start.dis
	rm object -rf

