import os
import ifcb
from file import newBin
import re
from ifcb.io import Timestamped, ADC_EXT, HDR_EXT, ROI_EXT
from ifcb.util import gen2list
from ifcb.io.pids import parse_id
import os.path

# FIX q&d fix for #1202
import config

def no_day_dirs():
	return 'NO_DAY_DIRS' in dir(config) and config.NO_DAY_DIRS

"""Interpretation and traversal of IFCB directory structure"""

# represents a directory containing a single day's worth of data for a single instrument
class DayDir(Timestamped):
	"""Represents an instrument/day directory (e.g., IFCB5_2011_0132)
	
	Iterable: returns all bins"""
	dir = '.'
	time_format = '%Y_%j' # FIXME ID format
	
	def __init__(self, dir='.'):
		self.dir = dir
		if not no_day_dirs():
			oid = parse_id(self.pid)
			self.time_format = oid.date_format
			self.time_string = oid.yearday
		else:
			self.time_string = '2000_001'
				
	def __repr__(self):
		return '{DayDir ' + self.pid +' @ '+str(self.dir)+'}'
	
	@property
	def pid(self):
		if no_day_dirs():
			return self.dir
		return ifcb.pid(os.path.basename(self.dir))
	
	def __all_exist(self,path):
		(n,ext) = os.path.splitext(path)
		for e in [ADC_EXT, HDR_EXT, ROI_EXT]:
			if not os.path.exists('.'.join([n,e])):
				return False
		return True
	
	def __iter__(self):
		try:
			exts = {}
			for item in sorted(os.listdir(self.dir)):
				f = os.path.join(self.dir, item)
				if re.search(r'\.[a-z]+$',f):
					(lid,ext) = re.match('.*/(.*)\.([a-z]+)$',f).groups()
					if lid not in exts:
						exts[lid] = []
					# exclude bins with roi files 2 bytes in length
					if not (ext=='roi' and os.stat(f).st_size == 2):
						exts[lid].append(ext)
					if 'hdr' in exts[lid] and 'adc' in exts[lid] and 'roi' in exts[lid]:
						yield newBin(f)
		except OSError:
			pass
	
	def all_bins(self):
		"""Return all bins in this day"""
		return list(self)
	
# represents a directory containing day directories
class YearsDir:
	"""Represents a directory containing day directories.
	
	Iterable: returns all instrument/day directories in the years directory"""
	dir = '.'
	instrument = '.' # regex matching the IFCB{instrument}_ part of the dir name
	
	def __init__(self, dir='.', instrument='.'):
		self.dir = dir
		self.instrument = instrument

	def __iter__(self):
		if 'NO_DAY_DIRS' in dir(config) and config.NO_DAY_DIRS:
			yield DayDir(os.path.abspath(self.dir))
			return
		try:
			for item in sorted(os.listdir(self.dir)):
				f = os.path.join(self.dir, item)
				try:
					if parse_id(item).isday:
						yield DayDir(os.path.abspath(f))
					else:
						raise KeyError
				except KeyError:
					print '%s is not a day' % item # FIXME debug
		except OSError:
			noop = None # FIXME log
				
	def all_days(self):
		"""Return all day dirs in this directory"""
		return list(self)
	
