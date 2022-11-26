#!/usr/bin/python3

import sys

out="project.mml.d/"
orderfile = "order.txt"

with open(out+orderfile) as files:
  for file in files:
    sys.stdout.write(open(out+file.rstrip()).read())
