
CROSS_COMPILE = arm-linux-
CC = $(CROSS_COMPILE)gcc
CC_FLAGS = -c -I ./include -O3
LD = $(CROSS_COMPILE)ld
LD_FLAGS = -Ttext 0x50000000	#指定代码段的起始地址; 
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJCOPY_FLAGS = -O binary
OBJDUMP = $(CROSS_COMPILE)objdump
OBJDUMP_FLAGS = -D
TAG = start
OBJS = start.o main.o led.o key.o bell.o lib.o

all: $(OBJS)
	$(LD) $(LD_FLAGS) $(OBJS) -o $(TAG)
	$(OBJCOPY) $(OBJCOPY_FLAGS) $(TAG) $(TAG).bin
	$(OBJDUMP) $(OBJDUMP_FLAGS) $(TAG) > $(TAG).dis

%.o:%.s
	$(CC) $(CC_FLAGS) $^
%.o:%.S
	$(CC) $(CC_FLAGS) $^
%.o:%.c
	$(CC) $(CC_FLAGS) $^

clean:
	rm -rf *.o start.dis start start.bin
