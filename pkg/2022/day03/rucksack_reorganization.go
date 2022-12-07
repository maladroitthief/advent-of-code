package day03

import (
	"log"
	"strings"
	"unicode"
)

func Puzzle() {
	log.Println("Day 03: Rucksack Reorganization")
	log.Printf("Solution 1:\t%v\n", Solution1())
	log.Printf("Solution 2:\t%v\n", Solution2())
}

func Solution1() int {
	inputArr := strings.Split(input, "\n")
	totalPriority := 0
	for _, line := range inputArr {
		rs := NewRucksack(line)
		sharedItem := getSharedItem(rs)
		priority := getPriority(sharedItem)
		totalPriority += priority
	}

	return totalPriority
}

func Solution2() int {
	inputArr := strings.Split(input, "\n")
	totalPriority := 0
	for i := 0; i < len(inputArr); i += 3 {
		elf1 := NewRucksack(inputArr[i])
		elf2 := NewRucksack(inputArr[i+1])
		elf3 := NewRucksack(inputArr[i+2])

		elf1LUT := map[rune]int{}
		for i, r := range elf1.items {
			elf1LUT[r] = i
		}

		elf2LUT := map[rune]int{}
		for i, r := range elf2.items {
			_, exists := elf1LUT[r]
			if exists {
				elf2LUT[r] = i
			}
		}

		for _, r := range elf3.items {
			_, exists := elf2LUT[r]
			if exists {
				totalPriority += getPriority(r)
				break
			}
		}
	}

	return totalPriority
}

type rucksack struct {
	items             string
	firstCompartment  []rune
	secondCompartment []rune
}

func NewRucksack(s string) rucksack {
	runeArr := []rune(s)

	return rucksack{
		items:             s,
		firstCompartment:  runeArr[:len(s)/2],
		secondCompartment: runeArr[len(s)/2:],
	}
}

func getSharedItem(rs rucksack) rune {
	var result rune

	fcLUT := map[rune]int{}
	for i, r := range rs.firstCompartment {
		fcLUT[r] = i
	}

	for _, r := range rs.secondCompartment {
		_, exists := fcLUT[r]
		if exists {
			result = r
			break
		}
	}

	return result
}

func getPriority(r rune) int {
	var result int

	// abusing unicode shenanigans
	if unicode.IsUpper(r) {
		result = int(r) - 38
	} else {
		result = int(r) - 96
	}

	return result
}
