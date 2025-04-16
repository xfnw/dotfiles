#!/usr/bin/env perl
use Regexp::Assemble;@ARGV=shift;my$r=new Regexp::Assemble;chomp,add$r "^\Q$_\E\$"while<>;$_=as_string$r;s/\(\?:/(/g;print
