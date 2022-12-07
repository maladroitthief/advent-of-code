package day02

import (
	"log"
	"strings"
)

var rock string = "ROCK"
var paper string = "PAPER"
var scissors string = "SCISSORS"

var loss int = 0
var draw int = 3
var win int = 6

func Puzzle() {
	log.Println("Day 02: Rock Paper Scissors")
	log.Printf("Solution 1:\t%v\n", Solution1())
	log.Printf("Solution 2:\t%v\n", Solution2())
}

func Solution1() int {
	inputArr := strings.Split(input, "\n")
	totalScore := 0
	for _, line := range inputArr {
		round := strings.Split(line, " ")
		elf := rpsLUT(round[0])
		me := rpsLUT(round[1])

		roundScore := RPS(me, elf) + scoreLUT(me)
		totalScore += roundScore
	}

	return totalScore
}

func Solution2() int {
	inputArr := strings.Split(input, "\n")
	totalScore := 0
	for _, line := range inputArr {
		round := strings.Split(line, " ")
		elf := rpsLUT(round[0])
		me := choiceLUT(elf, round[1])

		roundScore := RPS(me, elf) + scoreLUT(me)
		totalScore += roundScore
	}

	return totalScore
}

func RPS(player1, player2 string) int {
	rockLUT := map[string]int{
		rock:     draw,
		paper:    loss,
		scissors: win,
	}
	paperLUT := map[string]int{
		rock:     win,
		paper:    draw,
		scissors: loss,
	}
	scissorsLUT := map[string]int{
		rock:     loss,
		paper:    win,
		scissors: draw,
	}

	switch player1 {
	case rock:
		return rockLUT[player2]
	case paper:
		return paperLUT[player2]
	case scissors:
		return scissorsLUT[player2]
	}

	return -1
}

func rpsLUT(input string) string {
	lut := map[string]string{
		"A": rock,
		"B": paper,
		"C": scissors,
		"X": rock,
		"Y": paper,
		"Z": scissors,
	}

	return lut[input]
}

func scoreLUT(input string) int {
	scoreLUT := map[string]int{
		rock:     1,
		paper:    2,
		scissors: 3,
	}

	return scoreLUT[input]
}

func choiceLUT(elfMove, outcome string) string {
	rockLUT := map[string]string{
		"X": scissors,
		"Y": rock,
		"Z": paper,
	}
	paperLUT := map[string]string{
		"X": rock,
		"Y": paper,
		"Z": scissors,
	}
	scissorsLUT := map[string]string{
		"X": paper,
		"Y": scissors,
		"Z": rock,
	}

	switch elfMove {
	case rock:
		return rockLUT[outcome]
	case paper:
		return paperLUT[outcome]
	case scissors:
		return scissorsLUT[outcome]
	}

	return ""
}
