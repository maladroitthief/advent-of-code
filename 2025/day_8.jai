#import "Basic";
#import "String";
#import "Sort";
#import "Hash_Table";
#import "Hash";

EXAMPLE :: #string DONE
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
DONE;

MAX_INT :: 9_223_372_036_854_775_807;

part_one :: (in: string) {
	log("part one");
	result :int;

	#if false {
		input := EXAMPLE;
	} else {
		input := in;
	}

	boxes :[..]Vector3;
	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		parts := split(line, ",");
		array_add(*boxes, .{to_integer(parts[0]), to_integer(parts[1]), to_integer(parts[2])});
	}

	size := boxes.count;
	edges :[..]Edge;

	for i: 0 .. size-2 {
		for j: i+1 .. size-1 {
			a, b := boxes[i], boxes[j];
			dist := distance(a, b);
			if dist < MAX_INT {
				array_add(*edges, .{a=i, b=j, distance=dist});
			}
		}
	}
	quick_sort(edges, (x, y) => x.distance - y.distance);

	dsu := new_dsu(size);
	for edges {
		a := dsu_find(*dsu, it.a);
		b := dsu_find(*dsu, it.b);

		if a != b {
			dsu_union(*dsu, it.a, it.b);
		}

		if it_index == size-1 {
			seen := NewArray(size, bool);
			sizes :[..]int;

			for i: 0 .. size-1 {
				root := dsu_find(*dsu, i);
				if seen[root] then continue;

				seen[root] = true;
				array_add(*sizes, dsu.size[root]);
			}

			quick_sort(sizes, (x, y) => y - x);
			result = sizes[0] * sizes[1] * sizes[2];

			break;
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

	boxes :[..]Vector3;
	lines := split(input, "\n");
	for line: lines {
		if line == "" then continue;

		parts := split(line, ",");
		array_add(*boxes, .{to_integer(parts[0]), to_integer(parts[1]), to_integer(parts[2])});
	}

	size := boxes.count;
	edges :[..]Edge;

	for i: 0 .. size-2 {
		for j: i+1 .. size-1 {
			a, b := boxes[i], boxes[j];
			dist := distance(a, b);
			if dist < MAX_INT {
				array_add(*edges, .{a=i, b=j, distance=dist});
			}
		}
	}
	quick_sort(edges, (x, y) => x.distance - y.distance);

	unions := 0;
	dsu := new_dsu(size);
	for edges {
		a := dsu_find(*dsu, it.a);
		b := dsu_find(*dsu, it.b);

		if a != b {
			dsu_union(*dsu, it.a, it.b);
			unions += 1;
		}

		if unions == size-1 {
			result = boxes[it.a].x * boxes[it.b].x;
			break;
		}
	}

	log("result: %", result);
}

Edge :: struct {
	a, b: int;
	distance: int;
}

Vector3 :: struct {
	x, y, z: int;
}

distance :: inline (a: Vector3, b: Vector3) -> int {
	return squared(a.x - b.x) + squared(a.y - b.y) + squared(a.z - b.z);
}

squared :: inline (a: int) -> int {
	return a * a;
}

DisjointSetUnion :: struct {
	parent: []int;
	size:   []int;
}

new_dsu :: (size: int) -> DisjointSetUnion {
	result := DisjointSetUnion.{
		parent = NewArray(size, int),
		size =   NewArray(size, int)
	};

	for 0 .. size-1 {
		result.parent[it] = it;
		result.size[it] =   1;
	}

	return result;
}

dsu_find :: (dsu: *DisjointSetUnion, x: int) -> int {
	root := x;

	while dsu.parent[root] != root {
		root = dsu.parent[root];
	}

	while dsu.parent[x] != x {
		next := dsu.parent[x];
		dsu.parent[x] = root;
		x = next;
	}

	return root;
}

dsu_union :: (dsu: *DisjointSetUnion, x: int, y: int) {
	root_x := dsu_find(dsu, x);
	root_y := dsu_find(dsu, y);

	if root_x == root_y then return;

	if dsu.size[root_x] < dsu.size[root_y] {
		root_x, root_y = root_y, root_x;
	}

	dsu.parent[root_y] = root_x;
	dsu.size[root_x] += dsu.size[root_y];
}
