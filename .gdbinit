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
class FrameSome(gdb.Function):
	def invoke(self):
		return gdb.selected_frame().name() is not None

FrameSome("frame_some")
end

define hook-stop
	while $_thread && $frame_some() && $_any_caller_matches("^__")
		up-silently
	end
end
