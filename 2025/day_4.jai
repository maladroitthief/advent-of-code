#import "Basic";
#import "String";

EXAMPLE :: #string DONE
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
DONE;

directions :[8][2]int: .[
	.[-1, -1],	
	.[-1, 0],	
	.[-1, 1],	
	.[0, -1],	
	.[0, 1],	
	.[1, -1],	
	.[1, 0],	
	.[1, 1],	
];

part_one :: (in: string) {
	log("part one");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	graph :[..][..]int;
	rows := split(input, "\n");

	for row: rows {
		if row == "" then continue;
		
		new_row :[..]int;

		for row {
			if it == {
			case ".";
				array_add(*new_row, 0);
			case "@";
				array_add(*new_row, 1);
			case;
				log_error("unexpected character: %", it);
			}
		}

		array_add(*graph, new_row);
	}

	for row, x: graph {
		for col, y: row {
			if graph[x][y] == 0 {
				// print(".");
				continue;
			}
		
			sum :int= 0;
			for directions {
				test_x := x + it[0];
				test_y := y + it[1];

				if 0 > test_x || test_x >= graph.count then continue;
				if 0 > test_y || test_y >= row.count then continue;

				sum += graph[test_x][test_y];
			}

			if sum < 4 {
				// print("X");
				result += 1;
			} else {
				// print("@");
			}
		}
		// print("\n");
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

	graph :[..][..]int;
	rows := split(input, "\n");

	for row: rows {
		if row == "" then continue;
		
		new_row :[..]int;

		for row {
			if it == {
			case ".";
				array_add(*new_row, 0);
			case "@";
				array_add(*new_row, 1);
			case;
				log_error("unexpected character: %", it);
			}
		}

		array_add(*graph, new_row);
	}

	removal :[..][2]int;
	tp_was_removed := true;
	while tp_was_removed {
		tp_was_removed = false;

		for row, x: graph {
			for col, y: row {
				if graph[x][y] == 0 {
					// print(".");
					continue;
				}
			
				sum :int= 0;
				for directions {
					test_x := x + it[0];
					test_y := y + it[1];

					if 0 > test_x || test_x >= graph.count then continue;
					if 0 > test_y || test_y >= row.count then continue;

					sum += graph[test_x][test_y];
				}

				if sum < 4 {
					// print("X");
					result += 1;
					array_add(*removal, .[x, y]);
					tp_was_removed = true;
				} else {
					// print("@");
				}
			}
			// print("\n");
		}

		for removal {
			graph[it[0]][it[1]] = 0;
		}
		array_reset(*removal);
	}

	log("result: %", result);
}
