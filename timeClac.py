#!/usr/bin/env python
import os
import time
from subprocess import check_call, STDOUT

DEVNULL = open(os.devnull, 'wb', 0)

start = time.time()
check_call(['sleep', '1'], stdout=DEVNULL, stderr=STDOUT)
print("{:.3f} seconds".format(time.time() - start))