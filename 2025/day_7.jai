#import "Basic";
#import "String";
#import "Sort";
#import "Hash_Table";
#import "Hash";

EXAMPLE :: #string DONE
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
DONE;

part_one :: (in: string) {
	log("part one");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	beams :[..]int;
	lines := split(input, "\n");
	start := find_index_from_left(lines[0], "S");
	array_add_if_unique(*beams, start);

	for line: lines {
		if it_index == 0 {
			continue;
		}
		if line == "" then continue;

		i := 0;
		while i < beams.count {
			defer i += 1;

			beam := beams[i];
			if line[beam] == {
				case "^";
					left := beam-1;
					right := beam+1;

					if left >= 0 {
						array_unordered_remove_by_index(*beams, i);
						array_add_if_unique(*beams, left);
					}
					if right < line.count {
						array_add_if_unique(*beams, right);
					}

					quick_sort(beams, (x, y) => x - y);
					result += 1;
			}
		}
	}

	log("result: %", result);
}

part_two :: (in: string) {
	log("part two");
	result :int= 1;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	lines := split(input, "\n");
	if lines[lines.count-1] == "" then lines.count -= 1;

  start :[2]int= .[
		find_index_from_left(lines[0], "S"),
		0
	];
	lut :Table(u32, int);

	result = dfs(*lut, start, lines);

	log("result: %", result);
}

Vector2 :: struct {
	x: int;
	y: int;
}

dfs :: (lut: *Table, pos: [2]int, graph: []string) -> int {
	result :int;

	if pos[1] == graph.count-1 then return 1;

	ok, cached := table_find(lut, get_hash(pos));
	if ok then return cached;

	if graph[pos[1]][pos[0]] == "." {
		result = dfs(lut, .[pos[0], pos[1]+1], graph);
	} else {
		if pos[0] > 0 {
			result = dfs(lut, .[pos[0]-1, pos[1]+1], graph);
		} 
		
		if pos[0] < graph[pos[1]].count-1 {
			result += dfs(lut, .[pos[0]+1, pos[1]+1], graph);
		}
	}

	table_set(lut, get_hash(pos), result);

	return result;
}
