// Copyright Traistaru Dragos-Andrei

# IOCLA-2

# 1. Remove Numbers

## Implementation Steps

1. Initialization
   - Two counters are initialized:
    - `ecx`: for the target vector
    - `ebx`: for the source vector

2. Checks for each number
   - For each number in the source vector, two checks are performed:
    1. Odd number check
    - The instruction `test eax, 1` is used
    - If the number is odd, it is skipped

    2. Power of 2 check
    - The formula `n & (n-1)` is used
    - If the result is 0, the number is a power of 2
    - Numbers that are powers of 2 are eliminated

3. Saving valid numbers
  - If a number passes both checks:
    - It is copied into the target vector
    - The target vector counter is incremented

# 2. Events

## Subtask1 Implementation (data validation)

In a loop, all events are iterated through, incrementing the base register by 36 bytes
at each step, because each event structure has a size of 36 bytes.

The following checks are performed in order:

1. Year check
  - The year must be between 1990 and 2030
  - This is checked using comparisons with the limits

2. Month check
  - The month must be between 1 and 12
  - This is checked using comparisons with the limits

3. Day check
  - The day must be valid for the given month
  - A `days_per_month` vector is used to check the maximum number of days
  - It checks if the day is between 1 and the maximum number of days for the corresponding month

## Subtask2 Implementation (event sorting)

1. Implementation
   - The bubble sort algorithm is used
   - For each pair of events, the following are compared in order:
     - validity flags
     - dates (year, month, day)
     - event names: comparison is done byte by byte and also handles the case
       where one of the strings is shorter than the other (by checking if the string terminator \0 is reached)
   - If needed, a swap operation is performed:
     - a temporary 36-byte buffer (size of one structure)
       is used for swapping
     - swapping is performed through 3 loops that copy the data
       of one structure byte by byte into a destination

# 3. Base64

## Implementation Steps

1. Length calculations
   - The output length is calculated: (input_length * 4) / 3
   - The number of iterations is calculated: input_length / 3

2. Processing groups
   - Each group of 3 bytes is processed into 4 base64 characters

   - The first character is determined by extracting the first 6 bits from the first byte,
   obtained by shifting it 2 positions to the right, and the resulting value
   is interpreted as an ASCII code.

   - The second character is built by combining two segments:
   the last 2 bits of the first byte and the first 4 bits of the second byte.
   To combine them into a 6-bit number:
      a. The 2 bits from the first byte are shifted left by 4 positions,
      b. Then the 4 bits from the second byte are added using an OR operation
      c. The result is used to obtain the corresponding character from
      the encoding alphabet.

   - The third character is built by combining the last 4 bits from
   the second byte and the first 2 bits from the third byte as follows:
      a. The 4 bits from the second byte are shifted left by 2 positions
      b. Then the 2 bits from the third byte are added using an OR operation
      c. The result is used to get the corresponding character
      from the encoding alphabet.

   - The fourth character is determined by the last 6 bits of the third byte

# 4. Sudoku

## Implementation Steps

1. Common characteristics
  - Each function uses a frequency vector to detect duplicate numbers

2. Implementation of check_row
  - Calculates the start position of the row using: row * 9
  - Iterates through all 9 elements in the row
  - Uses a frequency vector to detect duplicates
  - Returns 1 if valid, 2 if invalid

3. Implementation of check_column
  - Iterates through each row at the specified column
  - Calculates the correct row offset (row * 9)
  - Adds the column offset to get the exact position
  - Uses a frequency vector to detect duplicates
  - Returns 1 if valid, 2 if invalid

4. Implementation of check_box
  - Calculates the start position of the 3x3 box using:
    - row_box = box / 3 * 3
    - column_box = box % 3 * 3
  - Uses nested loops to iterate through the box
  - Returns 1 if valid, 2 if invalid
