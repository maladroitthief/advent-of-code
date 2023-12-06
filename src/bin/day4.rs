use advent_of_code_2023::runner;
use hashbrown::{HashMap, HashSet};
use itertools::Itertools;

type ScratchCard = (Vec<u32>, Vec<u32>);

fn main() {
    runner(part1);
    runner(part2);
}

fn part1(input: &str) {
    let games = parse_input(input);
    let mut points = 0;

    for (winning_numbers, my_numbers) in games.iter() {
        let mut winning_set: HashSet<u32> = HashSet::new();
        let mut my_set: HashSet<u32> = HashSet::new();
        winning_set.extend(winning_numbers);
        my_set.extend(my_numbers);

        let overlap_count: u32 = winning_set.intersection(&my_set).count() as u32;
        if overlap_count > 0 {
            points += 2_u32.pow(overlap_count - 1);
        }
    }

    println!("Day 4, Part 1: {}", points);
}

fn part2(input: &str) {
    let games = parse_input(input);
    let mut cards: Vec<u32> = Vec::new();
    cards.resize(games.len(), 1);

    for (i, (winning_numbers, my_numbers)) in games.iter().enumerate() {
        let mut winning_set: HashSet<u32> = HashSet::new();
        let mut my_set: HashSet<u32> = HashSet::new();
        winning_set.extend(winning_numbers);
        my_set.extend(my_numbers);
        let overlap_count: u32 = winning_set.intersection(&my_set).count() as u32;

        for j in i + 1..games.len().min(i + 1 + overlap_count as usize) {
            cards[j] += cards[i];
        }
    }

    println!("Day 4, Part 2: {}", cards.iter().sum::<u32>());
}

fn parse_input(input: &str) -> Vec<ScratchCard> {
    input
        .lines()
        .map(|line| {
            let (_, right) = line.split_once(':').unwrap();
            let game = parse_game(right);
            game
        })
        .collect_vec()
}

fn parse_game(game: &str) -> ScratchCard {
    let (left, right) = game.trim().split_once('|').unwrap();
    (parse(left), parse(right))
}

fn parse(input: &str) -> Vec<u32> {
    input
        .split_whitespace()
        .map(|s| s.parse::<u32>().unwrap())
        .collect::<Vec<u32>>()
}
