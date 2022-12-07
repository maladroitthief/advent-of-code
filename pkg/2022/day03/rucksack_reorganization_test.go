package day03_test

import (
	"testing"

	"github.com/maladroitthief/advent-of-code/pkg/2022/day03"
)

func BenchmarkSolution1(b *testing.B) {
	for i := 0; i < b.N; i++ {
		day03.Solution1()
	}
}

func BenchmarkSolution2(b *testing.B) {
	for i := 0; i < b.N; i++ {
		day03.Solution2()
	}
}
