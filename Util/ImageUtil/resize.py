from PIL import Image
import os

path = "../../../test"
count = 0

for file_name in os.listdir(path):
    if file_name.endswith(".png"):
        print(file_name)
        img = Image.open(path + '/' + file_name)
        # img = img.crop((left, top, right, bottom))
        img.thumbnail((400, 400), Image.ANTIALIAS)
        
        img.save(f"{path}/m_{count}.png", "png", quality=88, optimize=True)
        count += 1
