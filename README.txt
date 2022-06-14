rout - C Risc Os Unit Tests
====

rout has come from some my own unit tests on a few projects. It's nowhere near a full unit test framework, but some very lightweight utilities to help with unit testing on RISC OS, in C.

There are two main areas. The unit test helpers (Test.h) and the SWI mocker (SWIm.h).

Test.h - the test helpers
------
Test.h is really just a bunch of macros to help with writing tests. They should be fairly self explanatory

Let's do a bit of TDD. I've omitted the #includes for clarity.

int meaning(void)
{
    return 0; // Dummy implementation
}

void main()
{
    CHECK_EQ(meaning(), 42);
}

Will fail, because the returned value (0) doesn't equal the test value (42).

The output will be along the lines of:

"9: meaning() got 0, expected 42"

We can fix the return in meaning() to return 42; and the test will then pass. By default a passing tests generates no output, but defining SHOW_PASS (eg. with -DSHOW_PASS to the compiler) will make them verbose:

9: meaning() == 42 - PASSED

Because it's just a header, there's nothing to link with, but it makes writing tests that bit easier.

SWIm - the SWI mocker
---------------------
One of the most common ways to interact with other parts of the system on RISC OS is via SWIs. For tests, you might want to not actually call them because they will do things (testing that OS_Reset is called would be somewhat tricky) or because you want to control how they react. This is where SWIm helps.

SWIm works by keeping a list of expectations. Before running the code you want to test, you are bascially saying "I expect these SWIs to be called.". Along with the expected SWI, you can specify what to return in the registers, or what error to return.

After running the code under test, you can check all the things you expected to be called were.

The code you want to test will need #include SWIm.h when it's being built to test, a bit like this

#include "swis.h"
#ifdef SWIM
#include "rout:SWIm.h"
#endif

In order to use SWIm, you will need to link with rout (rout:o.rout)
