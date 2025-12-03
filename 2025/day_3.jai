#import "Basic";
#import "String";

EXAMPLE :: #string DONE
987654321111111
811111111111119
234234234234278
818181911112111
DONE;

part_one :: (in: string) {
	log("part one");

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	result :int;

	banks := split(input, "\n");
	for bank: banks {
		if bank == "" then continue;

		l := 0;
		r := bank.count-1;
		joltage := 0;

		while l < r {
			defer l += 1;

			while r > l {
				defer r -= 1;

				left 	:int= (bank[l] - #char "0");
				right :int= bank[r] - #char "0";

				test := (left * 10) + right;

				if test > joltage then joltage = test;
			}

			r = bank.count-1;
		}

		result += joltage;
	}

	log("result: %", result);
}

part_two :: (in: string) {
	log("part two");

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	result :int;
	banks := split(input, "\n");

	for bank: banks {
		if bank == "" then continue;

		result += find_jolts(bank, 12);
	}

	log("result: %", result);
}

find_jolts :: (bank: string, digits: int) -> int {
	result :int;

	index := -1;
	for < 1 .. digits {
		jolts: int;
		jolts, index = find_max(bank, index + 1, bank.count - it + 1);

		result = (result * 10) + jolts;
	}
	
	return result;
}

find_max :: (s: string, start: int, end: int) -> (int, int) {
	max: u8;
	index: int;

	for start .. end-1 {
		if s[it] <= max then continue;

		max = s[it];
		index = it;
	}
	
	return max - "0", index;
}
