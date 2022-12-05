package day05

import (
	"log"
	"strconv"
	"strings"
)

func Puzzle() {
	log.Println("Day 05: Supply Stacks")
	Solution1()
	Solution2()
}

func Solution1() {
	inputArr := strings.Split(input, "\n")
	stack := NewStack()

	for _, line := range inputArr {
		splitCommand := strings.Split(line, " ")
		moveCount, _ := strconv.Atoi(splitCommand[1])
		fromCommand := splitCommand[3]
		toCommand := splitCommand[5]

		for i := 0; i < moveCount; i++ {
			from := stack.crates[fromCommand]
			to := stack.crates[toCommand]

			from, to = rearrangeStack(1, from, to)

			stack.crates[fromCommand] = from
			stack.crates[toCommand] = to
		}
	}

	topCrates := topCrate(stack.crates["1"])
	topCrates = topCrates + topCrate(stack.crates["2"])
	topCrates = topCrates + topCrate(stack.crates["3"])
	topCrates = topCrates + topCrate(stack.crates["4"])
	topCrates = topCrates + topCrate(stack.crates["5"])
	topCrates = topCrates + topCrate(stack.crates["6"])
	topCrates = topCrates + topCrate(stack.crates["7"])
	topCrates = topCrates + topCrate(stack.crates["8"])
	topCrates = topCrates + topCrate(stack.crates["9"])

	log.Printf("Solution 1:\t%v\n", topCrates)
}

func Solution2() {
	inputArr := strings.Split(input, "\n")
	stack := NewStack()

	for _, line := range inputArr {
		splitCommand := strings.Split(line, " ")
		moveCount, _ := strconv.Atoi(splitCommand[1])
		fromCommand := splitCommand[3]
		toCommand := splitCommand[5]

		from := stack.crates[fromCommand]
		to := stack.crates[toCommand]
		from, to = rearrangeStack(moveCount, from, to)

		stack.crates[fromCommand] = from
		stack.crates[toCommand] = to
	}

	topCrates := topCrate(stack.crates["1"])
	topCrates = topCrates + topCrate(stack.crates["2"])
	topCrates = topCrates + topCrate(stack.crates["3"])
	topCrates = topCrates + topCrate(stack.crates["4"])
	topCrates = topCrates + topCrate(stack.crates["5"])
	topCrates = topCrates + topCrate(stack.crates["6"])
	topCrates = topCrates + topCrate(stack.crates["7"])
	topCrates = topCrates + topCrate(stack.crates["8"])
	topCrates = topCrates + topCrate(stack.crates["9"])

	log.Printf("Solution 2:\t%v\n", topCrates)
}

func rearrangeStack(count int, from, to string) (string, string) {
	crate := from[0:count]
	from = from[count:]
	to = string(crate) + to

	return from, to
}

func topCrate(stack string) string {
	return string(stack[0])
}
