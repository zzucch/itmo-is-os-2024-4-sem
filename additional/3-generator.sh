#!/usr/bin/env bash

function count_matching_digits() {
	local num1=$1
	local num2=$2

	count=0

	while [[ $num1 -gt 0 ]] && [[ $num2 -gt 0 ]]; do
		local digit1=$((num1 % 10))
		local digit2=$((num2 % 10))

		if [[ $digit1 -eq $digit2 ]]; then
			((count++))
		fi

		num1=$((num1 / 10))
		num2=$((num2 / 10))
	done

	echo "$count"
}

function count_occurrent_numbers() {
	local initial_original_num=$1
	local original_num=$1
	local guess_number=$2

	count=0

	while [[ $original_num -gt 0 ]] && [[ $guess_number -gt 0 ]]; do
		local original_digit=$((original_num % 10))
		local guess_digit=$((guess_number % 10))

		if [[ ! $original_digit -eq $guess_digit ]]; then
			local copy_original_num=$initial_original_num

			while [[ $copy_original_num -gt 0 ]]; do
				local copy_original_digit=$((copy_original_num % 10))

				if [[ $guess_digit -eq $copy_original_digit ]]; then
					((count++))
				fi

				copy_original_num=$((num2 / 10))
			done
		fi

		original_num=$((original_num / 10))
		guess_number=$((guess_number / 10))
	done

	echo "$count"
}

readonly min_number=10000
readonly max_number=99999

readonly max_guess_count=50
readonly max_matching_digits=5

script_dir="$(dirname "$0")"

readonly guess_pipe_name="$script_dir"/guesses
readonly response_pipe_name="$script_dir"/responses

if [[ ! -p $response_pipe_name ]]; then
	mkfifo "$response_pipe_name"
fi

readonly max_random=32768
random_number=$((RANDOM * (max_number - min_number + 1) / max_random + min_number))

echo "random number is $random_number"

guess_count=0
(tail -F "$guess_pipe_name") |
	while read -r guess; do
		((guess_count++))

		matching_digits=$(count_matching_digits "$random_number" "$guess")
		occurring_numbers=$(count_occurrent_numbers "$random_number" "$guess")

		echo "$matching_digits $occurring_numbers"
		echo "$matching_digits $occurring_numbers" >>"$response_pipe_name"

		if [[ $matching_digits -eq $max_matching_digits ]]; then
			echo "guessed correctly"
			echo "guessed correctly" >>"$response_pipe_name"

			exit 0
		else
			if [[ $guess_count -eq $max_guess_count ]]; then
				echo "failed to guess $random_number"
				echo "failed to guess $random_number" >>"$response_pipe_name"

				exit 0
			fi

			echo "you have $((max_guess_count - guess_count)) attempts left"
			echo "you have $((max_guess_count - guess_count))" \
				"attempts left" >>"$response_pipe_name"
		fi

	done
