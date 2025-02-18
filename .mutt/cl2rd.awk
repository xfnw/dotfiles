match($0, /^Lines: ([0-9]*)$/, l) {
	if (lines < 0)
		lines = l[1] + 2;
}
/^>*From / {
	if (lines <= 0)
		print $0;
	else
		print ">" $0;
	lines -= 1;
	next;
}
{
	print $0;
	lines -= 1;
}
