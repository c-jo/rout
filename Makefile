# Makefile for examplelib

COMPONENT = rout

# This is a list of source/object files for the library, only 1 in this simple example
OBJS = SWIm

include CLibrary

# Dynamic dependencies:
o.SWIm:	c.SWIm
o.SWIm:	h.SWIM
o.SWIm:	C:h.kernel
o.SWIm:	C:h.swis
