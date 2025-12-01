#import "Basic";
#import "String";


DIAL_MIN :: 0;
DIAL_MAX :: 99;

Direction :: enum int {
	NONE;
	LEFT;
	RIGHT;
}

part_one :: (input: string) {
	log("part one");

  builder: String_Builder;
  init_string_builder(*builder);

	dial := 50;
	direction :Direction= .NONE;
	pointing_at_zero :int= 0;

  for input {
		if it == {
		case #char "L";
			direction = .LEFT;
		case #char "R";
			direction = .RIGHT;
		case #char "0"; #through;
		case #char "1"; #through;
		case #char "2"; #through;
		case #char "3"; #through;
		case #char "4"; #through;
		case #char "5"; #through;
		case #char "6"; #through;
		case #char "7"; #through;
		case #char "8"; #through;
		case #char "9";
  		append(*builder, it);
		case;
			clicks := to_integer(builder_to_string(*builder));

			if direction == {
			case .RIGHT;
				dial = (dial + clicks) % 100;
			case .LEFT;
				dial = (dial - clicks) % 100;
			case;
				log_error("direction not set");
				exit(1);
			}

			if dial == 0 then pointing_at_zero += 1;
		}
	}

	log("answer: %", pointing_at_zero);
}

part_two :: (input: string) {
	log("part two");

  builder: String_Builder;
  init_string_builder(*builder);

	dial := 50;
	direction :Direction= .NONE;
	pointing_at_zero :int= 0;

  for input {
		if it == {
		case #char "L";
			direction = .LEFT;
		case #char "R";
			direction = .RIGHT;
		case #char "0"; #through;
		case #char "1"; #through;
		case #char "2"; #through;
		case #char "3"; #through;
		case #char "4"; #through;
		case #char "5"; #through;
		case #char "6"; #through;
		case #char "7"; #through;
		case #char "8"; #through;
		case #char "9";
  		append(*builder, it);
		case;
			clicks := to_integer(builder_to_string(*builder));

			if direction == {
			case .RIGHT;
				pointing_at_zero += cast(int) ((dial + clicks) / 100);

				dial = (dial + clicks + 100) % 100;
			case .LEFT;
				pointing_at_zero += cast(int) (clicks / 100);
				clicks = clicks % 100;

				if dial != 0 && (dial - clicks <= 0) {
					pointing_at_zero += 1;
				}

				dial = (dial - clicks + 100) % 100;
			case;
				log_error("direction not set");
				exit(1);
			}
		}
	}

	log("answer: %", pointing_at_zero);
}
