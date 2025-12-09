#import "Basic";
#import "Compiler";
#import "String";
#import "Curl" () (LINUX_USE_SYSTEM_LIBRARY = true);
#import "File";

day_1 :: #import,file "day_1.jai";
day_2 :: #import,file "day_2.jai";
day_3 :: #import,file "day_3.jai";
day_4 :: #import,file "day_4.jai";
day_5 :: #import,file "day_5.jai";
day_6 :: #import,file "day_6.jai";
day_7 :: #import,file "day_7.jai";
day_8 :: #import,file "day_8.jai";
day_9 :: #import,file "day_9.jai";


URL :: "https://adventofcode.com/2025/day/";
INPUT_PATH :: "input/";

curl: *CURL;

#run {
	set_build_options_dc(.{ do_output = false });

	year := 2025;
	day := 9;

	input := get_input(year, day);

	if day == {
	case 1;
		day_1.part_one(input);
		day_1.part_two(input);
	case 2;
		day_2.part_one(input);
		day_2.part_two(input);
	case 3;
		day_3.part_one(input);
		day_3.part_two(input);
	case 4;
		day_4.part_one(input);
		day_4.part_two(input);
	case 5;
		day_5.part_one(input);
		day_5.part_two(input);
	case 6;
		day_6.part_one(input);
		day_6.part_two(input);
	case 7;
		day_7.part_one(input);
		day_7.part_two(input);
	case 8;
		day_8.part_one(input);
		day_8.part_two(input);
	case 9;
		day_9.part_one(input);
		day_9.part_two(input);
	}
}

get_input :: (year: int, day: int) -> string {
  if !make_directory_if_it_does_not_exist(INPUT_PATH) then exit(1);

	path := sprint("%day_%.txt", INPUT_PATH, day);
	input, ok := read_entire_file(path);
	if !ok {
		url := sprint("https://adventofcode.com/%/day/%/input", year, day);
		download(url, path);
		input, ok := read_entire_file(path);

		if !ok {
			log_error("failed to download file");
			exit(1);
		}
	}

	return input;
}

write_callback :: (contents: *u8, count: u64, size: u64, file: *File) -> u64 #c_call {
  total_size := count * size;
  push_context {
    file_write(file, contents, cast(s64) total_size);
    print_curl_stats();
  }

  return total_size;
}

print_curl_stats :: () {
  total_time      : float64;
  download_speed  : float64;
  size_downloaded : float64;

  curl_easy_getinfo(curl, .TOTAL_TIME,     *total_time);
  curl_easy_getinfo(curl, .SPEED_DOWNLOAD, *download_speed);
  curl_easy_getinfo(curl, .SIZE_DOWNLOAD,  *size_downloaded);

  log("Time: %s, Speed: %MB/s, Downloaded: %MB\n", total_time, download_speed / 1024.0 / 1024.0, size_downloaded / 1024.0 / 1024.0);
}

download :: (url: string, target: string) -> bool {
  curl = curl_easy_init();
  if !curl {
    log_error("An error occured while initting up the Curl connection, but Curl doesn't tell us why.\n");
    return false;
  }
  defer curl_easy_cleanup(curl);

  curl_easy_setopt(curl, .URL, temp_c_string(url));

  out_file, ok := file_open(target, for_writing=true);
  if !ok {
    log_error("Failed to open the output file '%' for storing the download.\n", target);
    return false;
  }
  defer file_close(*out_file);

  cookie := read_entire_file("cookie");

  curl_easy_setopt(curl, .FOLLOWLOCATION, 1);
  curl_easy_setopt(curl, .WRITEFUNCTION, write_callback);
  curl_easy_setopt(curl, .WRITEDATA, *out_file);
  curl_easy_setopt(curl, .COOKIE, temp_c_string(cookie));

  log("Downloading %...\n", target);
  error_code := curl_easy_perform(curl);
  if error_code != .OK {
    error_message := to_string(curl_easy_strerror(error_code));
    defer free(error_message);
    print("Curl Error: %\n", error_message);
    return false;
  }

  print_curl_stats();
  log("File % downloaded successfully!\n", target);
  return true;
}
