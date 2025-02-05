set confirm off

# FIXME: find a less fragile way to detect debuginfod support
if $_shell("[ -e /usr/lib/libdebuginfod.so ]") == 0
	set debuginfod enabled on
end

alias hide = tui disable
define asm
	layout asm
	layout reg
end
define src
	layout src
	layout reg
end

python
import re

class FrameMatches(gdb.Function):
	def invoke(self, pattern):
		pat = re.compile(pattern.string())
		name = gdb.selected_frame().name()
		if name is None:
			return False
		return pat.match(name) is not None

FrameMatches("frame_matches")
end

define hook-stop
	while $_thread && $frame_matches("^__")
		up-silently
	end
end
