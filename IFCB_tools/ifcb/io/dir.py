import os
import ifcb
from file import BinFile
import re
from ifcb.io import Timestamped
from ifcb.util import gen2list

# represents a directory containing a single day's worth of data for a single instrument
class DayDir(Timestamped):
	dir = '.'
	time_format = '%Y_%j'
	
	def __init__(self, dir='.'):
		self.dir = dir
				
	def __repr__(self):
		return 'DayDir:' + self.dir
	
	def time_string(self):
		return re.sub('^IFCB\\d+_','',self.dir)
	
	def pid(self):
		return ifcb.pid(os.path.basename(self.dir))
	
	@gen2list
	def all_bins(self):
		for f in sorted(os.listdir(self.dir)):
			if re.search(r'\.adc$',f):
				yield BinFile(re.sub(r'\.adc','',f),self.dir)
	
# represents a directory containing day directories
class YearsDir:
	dir = '.'
	instrument = '.' # regex matching the IFCB{instrument}_ part of the dir name
	
	def __init__(self, dir='.', instrument='.'):
		self.dir = dir
		self.instrument = instrument

	@gen2list		
	def all_days(self):
		for f in sorted(os.listdir(self.dir)):
			if re.match(r'IFCB'+str(self.instrument)+r'_\d\d\d\d_\d\d\d',f):
				yield DayDir(f)
