# create a mosaic image containing multiple ROI's from the given bin
from PIL import Image
from ifcb.binpacking import JimScottRectanglePacker, CygonRectanglePacker
from ifcb.io import HEIGHT, WIDTH, TARGET_NUMBER
from ifcb.io.file import BinFile
import math

def mosaic(bin, width, height, size=0):
    mosaic = Image.new('L', (width, height))
    mosaic.paste(160,(0,0,width,height))
    packer = JimScottRectanglePacker(width, height)
    targets = sorted(bin.all_targets(), key=lambda t: 0 - (t.info[HEIGHT] * t.info[WIDTH]))
    for target in targets:
        h = target.info[WIDTH] # rotate 90 degrees
        w = target.info[HEIGHT] # rotate 90 degrees
        if w * h > size:
            p = packer.TryPack(w, h)
            if p is not None:
                mosaic.paste(target.image(), (p.x, p.y))
    return mosaic
            
if __name__=='__main__':
    width = 1920
    height = 1080
    bin = BinFile('../exampleData/IFCB1_2011_231/IFCB1_2011_231_182610.roi')
    #bin = BinFile('../exampleData/IFCB1_2009_216/IFCB1_2009_216_075913.roi')
    m = mosaic(bin, width, height)
    m.thumbnail((800,600))
    with open('/Users/jfutrelle/Pictures/bar.png','wb') as f:
        m.save(f,'png')