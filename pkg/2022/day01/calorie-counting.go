package day01

import (
	"log"
	"sort"
	"strconv"
	"strings"
)

type Elf struct {
	calories      []int
	totalCalories int
}

func Puzzle() {
	log.Println("Day 01: Calorie Counting")
	Solution1()
	Solution2()
}

func Solution1() {
	inputArr := strings.Split(input, "\n")

	elves := []Elf{}
	currentElf := Elf{}

	// Load the elves
	for _, line := range inputArr {
		if line == "" {
			elves = append(elves, currentElf)
			currentElf = Elf{}
			continue
		}

		calories, err := strconv.Atoi(line)
		if err != nil {
			log.Fatal(err)
		}
		currentElf.calories = append(currentElf.calories, calories)
		currentElf.totalCalories += calories
	}

	// sort the elves
	sort.SliceStable(elves, func(i, j int) bool {
		return elves[i].totalCalories > elves[j].totalCalories
	})

	log.Printf("Solution 2:\t%v\n", elves[0].totalCalories)
}

func Solution2() {
	inputArr := strings.Split(input, "\n")

	elves := []Elf{}
	currentElf := Elf{}

	// Load the elves
	for _, line := range inputArr {
		if line == "" {
			elves = append(elves, currentElf)
			currentElf = Elf{}
			continue
		}

		calories, err := strconv.Atoi(line)
		if err != nil {
			log.Fatal(err)
		}
		currentElf.calories = append(currentElf.calories, calories)
		currentElf.totalCalories += calories
	}

	// sort the elves
	sort.SliceStable(elves, func(i, j int) bool {
		return elves[i].totalCalories > elves[j].totalCalories
	})

	top3 := elves[0].totalCalories + elves[1].totalCalories + elves[2].totalCalories
	log.Printf("Solution 2:\t%v\n", top3)
}
