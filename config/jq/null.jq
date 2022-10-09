# https://github.com/jqnpm/jq-stress/blob/master/jq/main.jq
def replace(a; b):
	split(a)
	| join(b);

def remove(a):
	replace(a; "");

# The name was chosen because 'reverse' is a jq builtin.
# Also, https://github.com/mathiasbynens/esrever seems to do the right thing and is inspiring.
def esrever:
	explode
	| reverse
	| implode;

def isEmpty:
	. == "";

def isEmpty(fallback):
	if isEmpty then
		fallback
	else
		.
	end;

def isNullOrEmpty:
	type == "null"
	or isEmpty;

def isNullOrEmpty(fallback):
	if isNullOrEmpty then
		fallback
	else
		.
	end;

def isNullOrWhitespace:
	isNullOrEmpty
	or test("^\\s+$");

def isNullOrWhitespace(fallback):
	if isNullOrWhitespace then
		fallback
	else
		.
	end;

def isNotNull(fallback):
	if isNullOrWhitespace then
    .
	else
		fallback
	end;
