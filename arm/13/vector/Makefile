
CROSS_COMPILE = arm-linux-
CC = $(CROSS_COMPILE)gcc
CC_FLAGS = -c -I ./include
LD = $(CROSS_COMPILE)ld
#-Ttext 0x50000000 -Tdata 0x50000400 指定代码段的起始地址 
LD_FLAGS = -T start.lds
LD_FLAGS += -EL
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJCOPY_FLAGS = -O binary
OBJDUMP = $(CROSS_COMPILE)objdump
OBJDUMP_FLAGS = -D
TAG = start
OBJS = start.o main.o
OBJS += led.o key.o bell.o lib.o
OBJS += s5p_gpio.o adc.o mode.o 
OBJS += cp15.o mmu.o vector.o reset.o
LIBCS += libc.a

all: $(OBJS)
	$(LD) $(LD_FLAGS) $(OBJS) $(LIBCS) -o $(TAG)
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
