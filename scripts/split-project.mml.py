#!/usr/bin/python3

import sys,os

out="project.mml.d/"
orderfile = "order.txt"
oname = "head"

if not os.path.isdir(out):
  os.mkdir(out)

of = open(out+orderfile,"w+")

of.write(oname+'\n')
cur = open(out+oname,"w+")
with open("project.mml") as p:
  for line in p:
    if "- id: " in line:
      oname = line.split(' ')[4].rstrip()
      of.write(oname+'\n')
      # sys.stdout.write(oname)
      cur.close()
      cur = open(out+oname,"w+")
    cur.write(line)

cur.close()
of.close()
