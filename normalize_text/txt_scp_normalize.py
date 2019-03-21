import argparse
from subprocess import Popen, PIPE
import os

def normalize_file(fname, outfname, lower=False, upper=False):
  try:
    f = open(fname, 'r')
    g = open(outfname, 'w')
    keys = []
    txts = []
    for l in f.readlines():
      k, txt = l.strip('\n').split(' ', 1)
      keys.append(k)
      txts.append(txt)
    to_tr = '\n'.join(txts)
    p = Popen(['./normalize.v1.sh'], stdin=PIPE, stdout=PIPE)
    if lower:
      out_txt = p.communicate(to_tr.encode('utf-8'))[0].decode('utf-8').lower().split('\n')
    elif upper:
      out_txt = p.communicate(to_tr.encode('utf-8'))[0].decode('utf-8').upper().split('\n')
    else:
      out_txt = p.communicate(to_tr.encode('utf-8'))[0].decode('utf-8').split('\n')

    l1 = len(keys)
    l2 = len(out_txt)
    print(l1, l2)
    assert l1 == l2
    g.writelines(["%s %s\n"%(keys[i], out_txt[i]) for i in range(l1)])
    f.close()
    g.close()
  except:
    print('cannot normalize %s, check filename and output directory'%fname)

def normalize_dir(path, outpath, lower=False, upper=False, same_dir = False):
  fnames = []
  for root, dirs, files in os.walk(path):
    if same_dir:
      outpath = root
    fnames += [(os.path.join(root, f), os.path.join(outpath, f+'.out')) for f in files if f.endswith("text.scp")]
  print(fnames)
  for fname, outfname in fnames:
    normalize_file(fname, outfname, lower, upper)


if __name__=="__main__":
  parser = argparse.ArgumentParser(description="Normalize text.scp files. Scans all subdirectories.")
  parser.add_argument('-o', '--outdir', type=str, default=os.getcwd()+'/out', help="specify output directory, by default store in ./out")
  parser.add_argument('-i', '--indirs', type=str, nargs='+', help='path of root directory in the tree where txt,scp files are located')
  parser.add_argument('-f', '--files', type=str, nargs='+', help='list of files to be inormalized')
  parser.add_argument('-u', '--upper', default=False, action='store_true', help='convert to uppercase')
  parser.add_argument('-l', '--lower', default=False, action='store_true', help='convert to lower case (priority over upper)')
  parser.add_argument('-s', '--same_dir', default=False, action='store_true', help='store files where they are located (overrides outdir)')
  args = parser.parse_args()
  print(args)
  if not args.same_dir:
    if not os.path.isdir(args.outdir):
      print('Creating output directory %s'%args.outdir)
      os.mkdir(args.outdir)
  if args.indirs != None:
    for d in args.indirs:
      normalize_dir(d, args.outdir, args.lower, args.upper, args.same_dir)
  if args.files != None:
    for fname in args.files:
      if args.same_dir:
        outpath = fname+'.out'
      else:
        outpath = './out'

