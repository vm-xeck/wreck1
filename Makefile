all: build
build: $(wildcard *.kn)
	@kuin -i main.kn -o w1.cpp -s $(KUIN_SYS_PATH) -e cpp
	@clang++ w1.cpp -o w1
	@rm w1.cpp
	
%.w1: w1
	@./w1 $@ > $(basename $@).ll
	@llc -opaque-pointers $(basename $@).ll
	@clang $(basename $@).s -o $(basename $@)
	@rm $(basename $@).ll
	@rm $(basename $@).s
clean:
	@rm w1

.PHONY: all build clean
