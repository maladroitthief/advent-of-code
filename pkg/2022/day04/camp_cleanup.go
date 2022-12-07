package day04

import (
	"log"
	"strconv"
	"strings"
)

func Puzzle() {
	log.Println("Day 04: Camp Cleanup")
	log.Printf("Solution 1:\t%v\n", Solution1())
	log.Printf("Solution 2:\t%v\n", Solution2())
}

func Solution1() int {
	totalPairsOverlapped := 0
	inputArr := strings.Split(input, "\n")
	for _, line := range inputArr {
		elves := strings.Split(line, ",")
		firstElf, secondElf := getElfSections(elves[0]), getElfSections(elves[1])
		isOverlap := isFullyOverlapped(firstElf, secondElf)
		if isOverlap {
			totalPairsOverlapped++
		}
	}

	return totalPairsOverlapped
}

func Solution2() int {
	totalPairsOverlapped := 0
	inputArr := strings.Split(input, "\n")
	for _, line := range inputArr {
		elves := strings.Split(line, ",")
		firstElf, secondElf := getElfSections(elves[0]), getElfSections(elves[1])
		isOverlap := isAnyOverlap(firstElf, secondElf)
		if isOverlap {
			totalPairsOverlapped++
		}
	}

	return totalPairsOverlapped
}

type elf struct {
	startingSection int
	endingSection   int
}

func getElfSections(s string) elf {
	sections := strings.Split(s, "-")
	section1, _ := strconv.Atoi(sections[0])
	section2, _ := strconv.Atoi(sections[1])

	return elf{startingSection: section1, endingSection: section2}
}

func isAnyOverlap(e1, e2 elf) bool {
	if e1.startingSection == e2.startingSection {
		return true
	}

	if e1.startingSection > e2.startingSection {
		e1, e2 = e2, e1
	}

	if e1.endingSection >= e2.startingSection {
		return true
	}

	return false
}

func isFullyOverlapped(e1, e2 elf) bool {
	if e1.startingSection == e2.startingSection {
		return true
	}

	if e1.startingSection > e2.startingSection {
		e1, e2 = e2, e1
	}

	if e1.endingSection >= e2.endingSection {
		return true
	}

	return false
}
