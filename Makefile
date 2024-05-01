CC=gcc
CFLAGS=-funroll-loops -g -Wall
OPTFLAGS=-funroll-loops -g -Wall
OBJS_COMMON=kernel.o rdtsc.o

all:	check calibrate measure

check:	$(OBJS_COMMON) -lm driver_check.o
	$(CC) -o $@ $^
calibrate: $(OBJS_COMMON) -lm driver_calib.o
	$(CC) -o $@ $^
measure: $(OBJS_COMMON) -lm driver.o
	$(CC) -o $@ $^

driver_check.o: driver_check.c
	$(CC) $(CFLAGS) -D CHECK -c $< -o $@
driver_calib.o: driver_calib.c
	$(CC) $(CFLAGS) -D CALIB -c $< -o $@
driver.o: driver.c
	$(CC) $(CFLAGS) -c $<

kernel.o: kernel.c
	$(CC) $(OPTFLAGS) -D $(OPT) -c $< -o $@

clean:
	rm -rf $(OBJS_COMMON) driver_check.o driver_calib.o driver.o check calibrate measure
