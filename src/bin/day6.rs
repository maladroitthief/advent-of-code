use advent_of_code_2023::runner;
use itertools::Itertools;

fn main() {
    runner(part1);
    runner(part2);
}

fn part1(input: &str) {
    let (times, distances) = parse_input(input);
    let mut score = 1;
    for (time, distance) in times.iter().zip(distances.iter()) {
        score *= race(*time, *distance);
    }

    println!("Day 6, Part 1: {}", score);
}

fn part2(input: &str) {
    let (times, distances) = parse_input(input);
    let time = concat(times);
    let distance = concat(distances);

    println!("Day 6, Part 2: {}", race(time, distance));
}

fn parse_input(input: &str) -> (Vec<u64>, Vec<u64>) {
    let (time, dist) = input.lines().collect_tuple().unwrap();
    (parse(time), parse(dist))
}

fn parse(text: &str) -> Vec<u64> {
    let (_, right) = text.split_once(':').unwrap();
    right
        .split_whitespace()
        .map(|c| c.parse::<u64>().unwrap())
        .collect::<Vec<u64>>()
}

fn race(time: u64, distance: u64) -> u64 {
    let mut wins = 0;
    for t in 1..time - 1 {
        let race_time = t * (time - t);
        if race_time > distance {
            wins += 1;
        }
    }

    wins
}

fn concat(data: Vec<u64>) -> u64 {
    data.iter().map(|d| d.to_string()).collect::<String>().parse().unwrap()
}
