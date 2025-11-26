import json
import sys
import py_compile

# Simple tool to compare two arb files and delete keys from the first file that are not in the second file

def compare_arb_files(file1, file2):
	print(f'Comparing {file1} and {file2}')
	# Load data from first file
	with open(file1, 'r') as f:
		data1 = json.load(f)

	# Load data from second file
	with open(file2, 'r') as f:
		data2 = json.load(f)

	# Get keys from each file
	keys1 = set(data1.keys())
	keys2 = set(data2.keys())
	# print out number of keys in each file
	print(f'Number of keys in {file1}: {len(keys1)}')
	print(f'Number of keys in {file2}: {len(keys2)}')
	# Find keys that are in the first file but not the second
	missing_keys = keys1 - keys2

	# Print missing keys
	print(f'Keys in {file1} but not in {file2} ({len(missing_keys)}):')
	for key in missing_keys:
		print(key)
		
	# Delete the keys that are not in the second file from the first file
	for key in missing_keys:
		del data1[key]
	
	print(f'Deleting keys from {file1} that are not in {file2}')

	#Save the first file with the missing keys deleted
	with open(file1, 'w') as f:
		json.dump(data1, f, indent=2)

# read file1 and file2 as parameter from command line
try:
	py_compile.compile('compare.py', doraise=True)
	print("No syntax errors found.")
except py_compile.PyCompileError as e:
	print(f"Syntax error in file: {e}")

# if no parameters were given, print out usage instructions
if len(sys.argv) < 3:
    print('Usage: python3 compare.py file1 file2 - removes keys from file1 that are not in file2')
    sys.exit(1)

# get first and second file from command line and compare
compare_arb_files(sys.argv[1], sys.argv[2])

# usage instruction: python3 compare.py file1 file2
