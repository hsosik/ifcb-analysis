# create a mosaic image containing multiple ROI's from the given bin
from PIL import Image
from ifcb.binpacking import JimScottRectanglePacker
from ifcb.io import HEIGHT, WIDTH, TARGET_NUMBER
from ifcb.io.file import BinFile
import math

from config import FS_ROOTS
import cgitb
import ifcb.io.cache

def mosaic(bin, width, height, size=0):
    mosaic = Image.new('L', (width, height))
    mosaic.paste(160,(0,0,width,height))
    packer = JimScottRectanglePacker(width, height)
    targets = sorted(bin.all_targets(), key=lambda t: 0 - (t.info[HEIGHT] * t.info[WIDTH]))
    good = 0
    bad = 0
    for target in targets:
        h = target.info[WIDTH] # rotate 90 degrees
        w = target.info[HEIGHT] # rotate 90 degrees
        if w * h > size:
            p = packer.TryPack(w, h)
            if p is not None:
                good = good + 1
                mosaic.paste(target.image(), (p.x, p.y))
            else:
                bad = bad + 1
    return mosaic
           
def thumbnail(image, width, height):
    image.thumbnail((width, height))
    return image

def test():
    width = 2000
    height = 1500
    #bin = BinFile('../exampleData/IFCB1_2011_231/IFCB1_2011_231_182610.roi')
    #bin = BinFile('../exampleData/IFCB1_2009_216/IFCB1_2009_216_075913.roi')
    #bin = BinFile('/Users/jfutrelle/Downloads/IFCB1_2011_248_160637.roi')
    m = mosaic(bin, width, height, 2500)
    m.thumbnail((800,600))
    with open('/Users/jfutrelle/Pictures/bar.png','wb') as f:
        m.save(f,'png')

if __name__=='__main__':
    cgitb.enable()
    (pid, ext) = os.path.splitext(cgi.FieldStorage().getvalue('pid'))
    print 'Content-type: image/png\n'
    bin = Filesystem(FS_ROOTS).resolve(pid)
    cache_key = ifcb.lid(pid) + '_thumb.png'
    cache.cache_io(cache_key, lambda o: thumbnail(mosaic(bin, 2000, 1500, 2500),800,600).save(o,format), sys.stdout)
    