#
# @Descripttion: cochat
# @version: 1.0.0
# @Author: cochat
# @Date: 2024-10-15 14:14:04
# @LastEditors: cochat
# @LastEditTime: 2024-12-04 15:59:58
#

import os, re

def file_rename(file_path: str, old_to_str: str, new_to_str: str):
    root_path = os.path.split(file_path)[0]
    root_name = os.path.split(file_path)[1]
    filename = os.path.splitext(root_name)[0]
    filetype = os.path.splitext(root_name)[1]

    filename = filename.replace(old_to_str, new_to_str)
    new_path = os.path.join(root_path, filename+filetype)
    os.renames(file_path, new_path)
    print(file_path + ' ------> ' + new_path)

    return filename

# 下划线命名转驼峰
def to_camel_case(snake_str):
    return re.sub(r'(^|_)(.)', lambda m: m.group(2).upper(), snake_str)

if __name__ == '__main__':
    print("\n")
    print("...")
    print("说明： ")
    print("1、项目路径必须是完整的绝对路径,不支持相对路径")
    print("2、文件前缀使用独一无二的字符串,推荐使用app名称")
    print("...")
    print("\n")

    project_path = input('请输入项目绝对路径: ').strip()
    old_to_str = input('请输入旧文件前缀: ').strip()
    new_to_str = input('请输入新文件前缀: ').strip().lower()

    print("start ...")
    suf_set = ('.dart', '.json',)
    suf_dirs = ('lib', 'assets', 'test')
    exc_dir_list = [os.path.join(project_path, dir) for dir in suf_dirs]

    for exc_dir_path in exc_dir_list:
        for root, dirs, files in os.walk(exc_dir_path):
            for file_name in files:
                if file_name.startswith(old_to_str):

                    old_name = os.path.splitext(file_name)[0]
                    new_name = file_rename(os.path.join(
                        root, file_name), old_to_str, new_to_str)

                    print('[file]: ' + os.path.join(
                        root, file_name) + ' -> ' + os.path.join(
                        root, new_name))

    for exc_dir_path in exc_dir_list:
        for root, dirs, files in os.walk(exc_dir_path):
            for file_name in files:
                if file_name.endswith(suf_set):
                    with open(os.path.join(root, file_name), 'r+') as f:
                        print('[file]: ' + (os.path.join(root, file_name)))
                        file_content = f.read()

                        file_content = file_content.replace(old_to_str, new_to_str)
                        print("[content]: " + old_to_str + ' -> ' + new_to_str)

                        file_content = file_content.replace(old_to_str.capitalize(), new_to_str.capitalize())
                        print("[content]: " + old_to_str.capitalize() + ' -> ' + new_to_str.capitalize())
                        
                        f.seek(0)
                        f.write(file_content)
                        f.truncate()
                        f.close()

    with open(os.path.join(project_path, 'pubspec.yaml'), 'r+') as f:
        print('[file]: ' + (os.path.join(root, file_name)))
        file_content = f.read()
        file_content = file_content.replace(old_to_str, new_to_str)
        print("[content]: " + old_to_str + ' -> ' + new_to_str)

        f.seek(0)
        f.write(file_content)
        f.truncate()
        f.close()

    with open(os.path.join(project_path, 'flutter_native_splash.yaml'), 'r+') as f:
        print('[file]: ' + (os.path.join(root, file_name)))
        file_content = f.read()
        file_content = file_content.replace(old_to_str, new_to_str)
        print("[content]: " + old_to_str + ' -> ' + new_to_str)

        f.seek(0)
        f.write(file_content)
        f.truncate()
        f.close()

    print("end ...")
