use advent_of_code_2023::runner;
use itertools::Itertools;

fn main() {
    runner(part1);
    runner(part2);
}

fn part1(input: &str) {
    let almanac = parse_input(input, false);

    println!("Day 5, Part 1: {}", process_map(almanac));
}

fn part2(input: &str) {
    let almanac = parse_input(input, true);

    println!("Day 5, Part 2: {}", process_map(almanac));
}

#[derive(Debug)]
struct Almanac {
    seeds: Vec<(i64, i64)>,
    maps: Vec<Vec<(i64, i64, i64)>>,
}

fn parse_input(input: &str, range: bool) -> Almanac {
    let mut almanac = Almanac {
        seeds: Vec::new(),
        maps: Vec::new(),
    };
    let blocks = input.split("\n\n").collect_vec();
    if range {
        almanac.seeds = blocks
            .first()
            .unwrap()
            .split_once(": ")
            .unwrap()
            .1
            .split(' ')
            .collect_vec()
            .windows(2)
            .step_by(2)
            .map(|s| {
                (
                    s.first().unwrap().parse::<i64>().unwrap(),
                    s.last().unwrap().parse::<i64>().unwrap(),
                )
            })
            .collect_vec();
    } else {
        almanac.seeds = blocks
            .first()
            .unwrap()
            .split_once(": ")
            .unwrap()
            .1
            .split(' ')
            .map(|s| (s.parse::<i64>().unwrap(), 1))
            .collect_vec();
    }
    almanac.maps = parse_blocks(blocks);

    almanac
}

fn parse_blocks(blocks: Vec<&str>) -> Vec<Vec<(i64, i64, i64)>> {
    blocks
        .iter()
        .skip(1)
        .map(|block| {
            block
                .lines()
                .skip(1)
                .map(|line| sscanf::scanf!(line, "{} {} {}", i64, i64, i64).unwrap())
                .collect_vec()
        })
        .collect_vec()
}

fn process_map(almanac: Almanac) -> i64 {
    let mut lowest_location = i64::MAX;

    for (start, length) in almanac.seeds {
        (start..start + length).for_each(|seed| {
            let mut i = seed;
            almanac.maps.iter().for_each(|map| {
                map.iter().try_for_each(|(dest, src, length)| {
                    Some({
                        if i >= *src && i <= *src + *length - 1 {
                            i = *dest + i - *src;
                            return None;
                        }
                    })
                });
            });
            if i < lowest_location {
                lowest_location = i;
            }
        });
    }

    lowest_location
}
