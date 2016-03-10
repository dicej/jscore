build/jscore: build/main.o
	clang $(<) -o $(@)

build/%.o: src/%.m
	@mkdir -p $(dir $(@))
	clang -fmodules -Wall -Werror -c $(<) -o $(@)
