all: build
build: $(wildcard *.kn)
	@~/Downloads/kuin_2021_08_17_src_ja/kuin -i main.kn -o w1.cpp -s ~/Downloads/kuin_2021_08_17_src_ja/sys/ -e cpp
	@g++ w1.cpp -o w1
	@rm w1.cpp
	
%.w1: w1
	@./w1 $@ > $(basename $@).ll
	@llc $(basename $@).ll
	@gcc $(basename $@).s -o $(basename $@)
	@rm $(basename $@).ll
	@rm $(basename $@).s
clean:
	@rm w1

.PHONY: all build clean
