import os
import ifcb
from file import BinFile
import re
from ifcb.io import Timestamped
from ifcb.util import gen2list
import os.path

"""Interpretation and traversal of IFCB directory structure"""

# represents a directory containing a single day's worth of data for a single instrument
class DayDir(Timestamped):
	dir = '.'
	time_format = '%Y_%j'
	
	def __init__(self, dir='.'):
		self.dir = dir
				
	def __repr__(self):
		return 'DayDir:' + self.dir
	
	def time_string(self):
		return re.sub('^IFCB\\d+_','',ifcb.lid(self.pid()))
	
	def pid(self):
		return ifcb.pid(os.path.basename(self.dir))
	
	def __iter__(self):
		for item in sorted(os.listdir(self.dir)):
			f = os.path.join(self.dir, item)
			if re.search(r'\.adc$',f):
				yield BinFile(os.path.abspath(f))
	
	def all_bins(self):
		list(self)
	
# represents a directory containing day directories
class YearsDir:
	dir = '.'
	instrument = '.' # regex matching the IFCB{instrument}_ part of the dir name
	
	def __init__(self, dir='.', instrument='.'):
		self.dir = dir
		self.instrument = instrument

	def __iter__(self):
		for f in sorted(os.listdir(self.dir)):
			if re.match(r'IFCB'+str(self.instrument)+r'_\d\d\d\d_\d\d\d',f):
				yield DayDir(f)
				
	def all_days(self):
		list(self)
	
