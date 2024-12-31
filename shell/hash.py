#
# @Descripttion: vochat
# @version: 1.0.0
# @Author: vochat
# @Date: 2024-10-15 14:14:04
# @LastEditors: vochat
# @LastEditTime: 2024-11-04 11:59:18
#

import random
import os
import string

def fileAppend(filename: str):
    chars = random.sample(string.ascii_uppercase, 1)
    myfile = open(filename, 'a')
    myfile.write(chars[0])
    myfile.close
    print(f"{filename} ... 完成")

def start_process(path: str, filter: str):
    file_list = os.listdir(path)
    for file in file_list: 
        if file.startswith('.'):
            continue
        full_path = path + '/' + file
        if os.path.isdir(full_path):
            start_process(full_path, filter)
        else:
            if full_path.endswith(filter):
                try:
                    fileAppend(full_path)
                except IOError:
                    continue

if __name__ == '__main__':
    print("start ...")
    project_path = input('请输入项目绝对路径: ').strip()
    filter = ('.png', '.jpg', '.jpeg', '.wav', '.mp3', '.webp')
    start_process(project_path, filter)
    print("end ...")
