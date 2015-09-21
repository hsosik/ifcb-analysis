%function [yrday_inv] = yearday_inv(daynum); 
% calculates date from day of the year,
% e.g., "yearday('nov 8,2007') returns 312
% yrday = yrday + temp(3); %day of present monthtemp = datevec(datename);
% yrday = 0;
% for i = 1:temp(2)-1 %month
%     yrday = yrday + eomday(temp(1), i);
% end
% yrday = yrday + temp(3); %day of present month

function theResult = yearday(theYear, theDay)

% yearday -- Convert date to year and day-of-year.
%  yearday(theDate) returns [year day], where the day
%   is a decimal date-number.  The given date can be
%   a Matlab datenum, datestr, or datevec.
%  yearday([theYear theDay]) returns the Matlab datenum
%   corresponding to theYear and theDay.
%  yearday(theYear, theDay) same as above.
%  yearday (no arguments) demonstrates itself by showing
%   a round-trip, using "now".
 
% Copyright (C) 1998 Dr. Charles R. Denham, ZYDECO.
%  All Rights Reserved.
%   Disclosure without explicit written consent from the
%    copyright owner does not constitute publication.
 
% Version of 09-Nov-1998 08:17:43.

if nargin < 1, theYear = 'demo'; end

if isequal(theYear, 'demo')
	help(mfilename)
	a = now;
	disp(datestr(a))
	b = yearday(yearday(a));
	disp(datestr(b))
	year_day_round_trip_error = b-a
	return
end

% Two arguments: year and day ==> datenum.

if nargin == 2, theYear = [theYear theDay]; end

if length(theYear) == 2
	theDay = theYear(2);
	theYear = theYear(1);
	d = [theYear 1 1 0 0 0];   % January 1, midnight.
	for i = 1:6
		v{i} = d(i);
	end
	result = datenum(v{:}) + theDay - 1;
	if nargout > 0
		theResult = result;
	else
		disp(result)
	end
	return
end

% One argument: date ==> year and day.

theDate = theYear;

if ischar(theDate)
	theDate = datenum(theDate);
elseif length(theDate) > 1
	for i = 1:length(theDate)
		v{i} = theDate(i);
	end
	theDate = datenum(v{:});
end

d = datevec(theDate);
d(2:6) = [1 1 0 0 0];   % January 1, midnight.
for i = 1:length(d)
	v{i} = d(i);
end
newYearsDay = datenum(v{:});

delta = (theDate-newYearsDay);

result = [d(1) (1+delta)];

if nargout > 0
	theResult = result;
else
	disp(result)
end
