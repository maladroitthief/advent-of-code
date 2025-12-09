#import "Basic";
#import "String";
#import "Sort";
#import "Math";
#import "Hash_Table";
#import "Hash";

EXAMPLE :: #string DONE
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
DONE;

part_one :: (in: string) {
	log("part one");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	pos :[..]V2;

	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		parts := split(line, ",");
		assert(parts.count == 2);
		
		array_add(*pos, vector(to_integer(parts[0]), to_integer(parts[1])));
	}

	quick_sort(pos, (x, y) => distance(x) - distance(y));

	for i: 0 .. pos.count-2 {
		for j: i .. pos.count-1 {
			rect :R2= .{min=pos[i], max=pos[j]};

			if area(rect) > result then result = area(rect);
		}
	}

	log("result: %", result);
}

part_two :: (in: string) {
	log("part two");
	result :int= 0;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	pos    :[..]V2;
	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		parts := split(line, ",");
		assert(parts.count == 2);
		
		array_add(*pos, vector(to_integer(parts[0]), to_integer(parts[1])));
	}

	edges :[..]Edge;
	for pos {
		i := it_index;
		j := i+1;
		if j >= pos.count then j = 0;

		edge := Edge.{a=pos[i], b=pos[j]};
		array_add(*edges, edge);
	}

	for i: 0 .. pos.count-2 {
		for j: i+1 .. pos.count-1 {
			rect :R2= .{min=pos[i], max=pos[j]};
			test_area := area(rect);
			if test_area < result then continue;
	
			for edge: edges {
				if intersects(edge, rect) continue j;
			}

			result = test_area;
		}
	}

	log("result: %", result);
}

vector :: inline (x: $T, y: T) -> V2 {
  return .{
    x = cast(int) x,
    y = cast(int) y
  };
}

V2 :: struct {
	x, y: int;
}

R2 :: struct {
	min, max: V2;
}

Edge :: struct {
	a, b: V2;
}

squared :: inline (a: int) -> int {
	return a * a;
}

distance :: inline (a: V2, b: V2 = .{0, 0}) -> int {
	return squared(a.x - b.x) + squared(a.y - b.y);
}

area :: inline (rect: R2) -> int {
	result := (abs(rect.min.x - rect.max.x) + 1) * (abs(rect.min.y - rect.max.y) + 1);

	return result;
}

intersects :: (edge: Edge, rect: R2) -> bool {
	rect_min_x := min(rect.min.x, rect.max.x) + 1;
	rect_max_x := max(rect.min.x, rect.max.x) - 1;
	rect_min_y := min(rect.min.y, rect.max.y) + 1;
	rect_max_y := max(rect.min.y, rect.max.y) - 1;

	edge_min_x := min(edge.a.x, edge.b.x);
	edge_max_x := max(edge.a.x, edge.b.x);
	edge_min_y := min(edge.a.y, edge.b.y);
	edge_max_y := max(edge.a.y, edge.b.y);;

	if edge_max_x < rect_min_x || edge_min_x > rect_max_x then return false;
	if edge_max_y < rect_min_y || edge_min_y > rect_max_y then return false;

	return true;
}
