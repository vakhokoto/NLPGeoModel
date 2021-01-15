import random, string
import logging

def write_to_file(data):
    file_name = ''
    for _ in range(10):
        file_name += random.choice(string.ascii_uppercase + string.digits)
    out_file = open('data/' + file_name, 'w+')
    out_file.write(data)

def main():
    file = open('kawiki-latest-pages-articles.txt', 'r')
    file_data = ''
    while True:
        line = file.readline()
        if not line:
            break
        if line == '----------------kai-kaci----------------\n':
            write_to_file(file_data)
            file_data = ''
        else:
            file_data += line

if __name__ == '__main__':
    main()