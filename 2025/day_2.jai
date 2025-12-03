#import "Basic";
#import "String";

EXAMPLE :: #string DONE
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
DONE;

part_one :: (in: string) {
	log("part one");

	#if true {
		input := EXAMPLE;
	} else {
		input := in;
	}

	result :int;

	ranges := split(input, ",");
	for range: ranges {
		parts := split(range, "-");

		start := to_integer(parts[0]);
		end :=   to_integer(parts[1]);

		for start..end {
			if !is_valid(it) {
				result += it;
			}
		}
	}

	log("result: %", result);
}

part_two :: (in: string) {
	log("part two");

	#if true {
		input := EXAMPLE;
	} else {
		input := in;
	}

	result :int;

	ranges := split(input, ",");
	for range: ranges {
		parts := split(range, "-");

		start := to_integer(parts[0]);
		end :=   to_integer(parts[1]);

		for start..end {
			if !is_validest(it) {
				result += it;
			}
		}
	}

	log("result: %", result);
}

is_valid :: (x: int) -> bool {
	word := sprint("%", x);

	first_half := slice(word, 0, cast(int) (word.count / 2.0));
	second_half := slice(word, cast(int) (word.count / 2.0), word.count);

	return first_half != second_half;
}

is_validest :: (x: int) -> bool {
	result :bool= true;
	word := sprint("%", x);

	for i: 0 .. cast(int) (word.count / 2.0)-1 {
		pattern := slice(word, 0, i+1);
		remainder := slice(word, i+1, word.count);
		while remainder.count > 0 {
			if pattern == slice(remainder, 0, pattern.count) {
				remainder = slice(remainder, pattern.count, remainder.count);
			} else {
				continue i;
			}
		}
		
		result = false;
		break;
	}

	return result;
}
