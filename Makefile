SRC := hoge.w1

build: w1
w1: $(wildcard *.kn)
	@~/Downloads/kuin_2021_08_17_src_ja/kuin -i main.kn -o w1.cpp -s ~/Downloads/kuin_2021_08_17_src_ja/sys/ -e cpp
	@g++ w1.cpp -o w1
	@rm w1.cpp
run: w1
	@./w1 $(SRC) > $(basename $(SRC)).ll
	@llc $(basename $(SRC)).ll
	@gcc $(basename $(SRC)).s -o $(basename $(SRC))
	@rm $(basename $(SRC)).ll
	@rm $(basename $(SRC)).s
	@./$(basename $(SRC)); echo $$?
clean:
	@rm w1

.PHONY: build run clean
