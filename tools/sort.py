# sort (json) arb file keys alphabetically
# take files as parameter from command line

import json
import os
import sys
import py_compile

#read files in folder and sort
def sort_arb_folder(folder):
    #get all files in folder
    files = os.listdir(folder)
    #print out all files in folder
    print(f'Files in {folder}:')
    for file in files:
        print(file)

    #sort all files in folder, use folder path and filename
    for file in files:
        sort_arb_file(folder + '/' + file)

# sort the keys in a json file alphabetically
def sort_arb_file(file):
   #read and sort the json
    with open(file, 'r') as f:
        data = json.load(f)
    sorted_data = dict(sorted(data.items()))
    #save the sorted json
    with open(file, 'w') as f:
        json.dump(sorted_data, f, indent=2,ensure_ascii=False)
    #print out the number o sorted keys and filename
    print(f'{len(sorted_data)} keys sorted in {file}')
    
# read file as parameter from command line
try:
    py_compile.compile('sort.py', doraise=True)
    #print("No syntax errors found.")
except py_compile.PyCompileError as e:
    print(f"Syntax error in file: {e}")

#if no parameter is given, print out instructions
if len(sys.argv) == 1:
    print('''
    Please provide a file or folder to sort.
    Example: python3 sort.py <file or folder>
    ''')

#read folder as parameter from command line, sort all files in folder
if len(sys.argv) == 2:
    sort_arb_folder(sys.argv[1])
