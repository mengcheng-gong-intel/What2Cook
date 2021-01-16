from PIL import Image
import os

path = '../../../what2cook_dataset'
count = 0

for file_name in os.listdir(path):
    if file_name.endswith(".png"):
        print(file_name)
        img = Image.open(path + '/' + file_name)
        img.thumbnail((400, 400), Image.ANTIALIAS)
        img.save(f'{path}/m_{count}.png', 'png', quality=88, optimize=True)
