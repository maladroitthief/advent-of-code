package day06

import (
	"log"
)

func Puzzle() {
	log.Println("Day 06: Tuning Trouble")
	Solution1()
	Solution2()
}

func Solution1() {
	m := NewMarker(4)
	markerAt := 0

	for i := 0; i < len(input); i++ {
		if i < m.size {
			m.Load(rune(input[i]))
			continue
		}

		if m.IsValid() {
			markerAt = i
			break
		}

		m.Load(rune(input[i]))
		m.Unload(rune(input[i-m.size]))
	}

	log.Printf("Solution 1:\t%v\n", markerAt)
}

func Solution2() {
	m := NewMarker(14)
	markerAt := 0

	for i := 0; i < len(input); i++ {
		if i < m.size {
			m.Load(rune(input[i]))
			continue
		}

		if m.IsValid() {
			markerAt = i
			break
		}

		m.Load(rune(input[i]))
		m.Unload(rune(input[i-m.size]))
	}

	log.Printf("Solution 2:\t%v\n", markerAt)
}

type Marker struct {
	queue map[rune]int
	size  int
}

func NewMarker(size int) *Marker {
	queue := map[rune]int{}
	return &Marker{queue: queue, size: size}
}

func (m *Marker) IsValid() bool {
	if len(m.queue) == m.size {
		return true
	}

	return false
}

func (m *Marker) Load(element rune) {
	_, exists := m.queue[element]
	if exists {
		m.queue[element]++
	} else {
		m.queue[element] = 1
	}
}

func (m *Marker) Unload(element rune) {
	count, exists := m.queue[element]
	if !exists {
		return
	}

	if count <= 1 {
		delete(m.queue, element)
	} else {
		m.queue[element]--
	}
}
