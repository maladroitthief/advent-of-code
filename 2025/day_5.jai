#import "Basic";
#import "String";
#import "Sort";

EXAMPLE :: #string DONE
3-5
10-14
16-20
12-18

1
5
8
11
17
32
DONE;

part_one :: (in: string) {
	log("part one");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	starts      :[..]int;
	ends        :[..]int;
	ingredients :[..]int;

	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		if contains(line, "-") {
			range := split(line, "-");
			assert(range.count == 2);

			start := to_integer(range[0]);
			end := to_integer(range[1]);
			if start > end {
				tmp := start;
				start = end;
				end = tmp;
			}

			array_add(*starts, start);
			array_add(*ends, end);
		} else {
			ingredient := to_integer(line);

			array_add(*ingredients, ingredient);
		}
	}

	assert(starts.count == ends.count);

	for ingredient: ingredients {
		for starts {
			if ingredient >= starts[it_index] && ingredient <= ends[it_index] {
				result += 1;
				break;
			}
		}
	}

	log("result: %", result);
}

part_two :: (in: string) {
	log("part two");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	ranges :[..][2]int;
	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		if contains(line, "-") {
			range := split(line, "-");
			assert(range.count == 2);

			start := to_integer(range[0]);
			end := to_integer(range[1]);
			if start > end {
				tmp := start;
				start = end;
				end = tmp;
			}

			array_add(*ranges, .[start, end]);
		}
	}

	quick_sort(ranges, (x, y) => x[0] - y[0]);

	current := 0;

	for ranges {
		if current > it[1] then continue;

		start := max(current, it[0]);
		if start <= it[1] {
			result += it[1] - start + 1;
		}

		current = it[1] + 1;
	}

	log("result: %", result);
}
