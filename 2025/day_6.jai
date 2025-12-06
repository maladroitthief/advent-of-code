#import "Basic";
#import "String";
#import "Sort";

EXAMPLE :: #string DONE
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
DONE;

part_one :: (in: string) {
	log("part one");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	homework :[..][..]string;

  builder: String_Builder;
  init_string_builder(*builder);

	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		row :[..]string;

		for line {
			if it == {
			case "+"; #through; 
			case "*"; #through;
			case "0"; #through;
			case "1"; #through;
			case "2"; #through;
			case "3"; #through;
			case "4"; #through;
			case "5"; #through;
			case "6"; #through;
			case "7"; #through;
			case "8"; #through;
			case "9";
  			append(*builder, it);
			case;
				x := builder_to_string(*builder);
				if x != "" then array_add(*row, x);
			}
		}

		x := builder_to_string(*builder);
		if x != "" then array_add(*row, x);

		array_add(*homework, row);
	}

	rows := homework.count;
	cols := homework[0].count;

	for x: 0 .. cols-1 {
		inner_result :int;
		adding :bool;

		if homework[rows-1][x] == {
		case "+";
			adding = true;
		case "*";
			adding = false;
		}

		for < y: 0 .. rows-2 {
			num := to_integer(homework[y][x]);

			if adding {
				inner_result += num;
			} else {
				if inner_result == 0 {
					inner_result += num;
				} else {
					inner_result *= num;
				}
			}
		}

		result += inner_result;
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

	operators: [..]string;
	homework :[..][..]string;

  builder: String_Builder;
  init_string_builder(*builder);

	lines := split(input, "\n");
	if lines[lines.count-1] == "" then lines.count -= 1;

	width := lines[0].count;
	height := lines.count;

	new_column := false;
	row :[..]string;

	for x: 0 .. width-1 {
		new_column = true;

		for y: 0 .. height-1 {
			char := lines[y][x];

			if char  == {
			case "+"; #through; 
			case "*";
				new_column = false;

				str := builder_to_string(*builder);
				if str != "" then array_add(*row, str);

				append(*builder, char);
				str = builder_to_string(*builder);
				array_add(*operators, str);
			case "0"; #through;
			case "1"; #through;
			case "2"; #through;
			case "3"; #through;
			case "4"; #through;
			case "5"; #through;
			case "6"; #through;
			case "7"; #through;
			case "8"; #through;
			case "9";
				new_column = false;
				append(*builder, char);
			case;
				str := builder_to_string(*builder);
				if str != "" then array_add(*row, str);
			}
		}

		if new_column && row.count > 0 {
			tmp :[..]string;
			array_copy(*tmp, row);
			array_add(*homework, tmp);
			array_reset(*row);
		}
	}

	if row.count > 0 {
		tmp :[..]string;
		array_copy(*tmp, row);
		array_add(*homework, tmp);
		array_reset(*row);
	}

	rows := homework.count;
	for < x: 0 .. rows-1 {
		cols := homework[x].count;
		inner_result :int;
		adding :bool;

		if operators[x] == {
		case "+";
			adding = true;
		case "*";
			adding = false;
		}

		for y: 0 .. cols-1 {
			num := to_integer(homework[x][y]);

			if adding {
				inner_result += num;
			} else {
				if inner_result == 0 {
					inner_result += num;
				} else {
					inner_result *= num;
				}
			}
		}

		result += inner_result;
	}

	log("result: %", result);
}
