# Author : mehul3.kumar@samsung.com
import os
import argparse

# Generates cmu_dict based phoneme output for text, if word not known, split into characters
def preprocess_txt(txt, dic, keep_words = False, sep='#', start_seq='<s>', end_seq='</s>'):
  res_list = [start_seq]
  for w in txt.lower().split(' '):
    if w in dic:
      res_list.extend(dic[w][0])
      res_list.append(sep)
    elif keep_words:
      res_list.append(w)
      res_list.append(sep) 
    else:
      res_list.extend(list(w))
      res_list.append(sep) 
  res_list.append(end_seq)
  return res_list

# Takes dictionary (trans.raw) files
# Generates vocab and phoneme stats files
# Generates preprocessed text
def convert_files(fnames, outpath, jobname='all', augmenting_dict = {}, keep_words=False):
  from collections import Counter
  try:
    from nltk.corpus import cmudict
    arpabet = cmudict.dict()
  except:
    import nltk
    nltk.download('cmudict') 
    from nltk.corpus import cmudict
    arpabet = cmudict.dict()
  arpabet.update(augmenting_dict)
  encountered = Counter()
  dstr = {}
  count = 0
  for fname, outfname in fnames:
    try:
      with open(fname, 'r') as f:
        d = eval(f.read())
      for k in list(d.keys()):
        res_list = preprocess_txt(d[k], arpabet, keep_words)
        encountered = encountered + Counter(res_list)
        dstr[k] = ' '.join(res_list)
      with open(outfname, 'w') as out_file:
        out_file.write(str(dstr))
    except Exception as e:
      print("Couldn't convert file %s"%fname)
      print(e)
  encountered = {a:b for (a,b) in encountered.most_common()}
  print("Final phonetic dictionary", encountered)
  with open(os.path.join(outpath, jobname+'.phonemes'),'w') as f:
    f.write(str(encountered))
  feature_dict = {w:i for i,w in enumerate(sorted(list(encountered.keys())+['<unk>']))} 
  with open(os.path.join(outpath, jobname+'.vocab'),'w') as f:
    f.write(str(feature_dict))
  return encountered

# Collect suffixed files in directory tree
def collect_files_in_dir(inpath, outpath, same_dir = False, suffix='trans.raw'):
  fnames = []
  for root, dirs, files in os.walk(path):
    if same_dir:
      outpath = root
    fnames += [(os.path.join(root, f), os.path.join(outpath, f+'.out')) for f in files if f.endswith(suffix)]
  return fnames

# Plots phoneme stats data
def plot_phonemes(enc):
  import numpy
  import matplotlib.pyplot as plt
  fig, ax = plt.subplots()
  data = list(enc.keys())
  x = numpy.arange(len(data)) 
  y = list(enc.values())
  plt.bar(x, y)
  plt.xticks(x, data, rotation=90)
  plt.show()

def run(args):
  allfnames = []
  # Create output directory
  if not os.path.isdir(args.outdir):
    print('Creating output directory %s'%args.outdir)
    os.mkdir(args.outdir)
  # Find all files in the directory trees
  if args.indirs != None:
    for d in args.indirs:
      allfnames.extend(collect_files_in_dir(d, args.out, args.same_dir, args.file_extension))
  # Find individual files
  if args.files != None:
    if args.same_dir:
      fnames = [(fname, fname+'.out') for fname in args.files]
    else:
      fnames = [(fname, os.path.join(args.outdir, (fname.split('/')[-1]+'.out'))) \
                for fname in args.files]
    allfnames.extend(fnames)
  # Augment arpabet with self defined phoneme transcriptions 
  try:
    with open(args.augmenting_dict, 'r') as f:
      augmenting_dict = eval(f.read())
  except:
    augmenting_dict = {}
  # Run convert job
  enc = convert_files(allfnames, args.outdir, args.jobprefix, augmenting_dict, args.keep_words)
  # Plot
  if args.plot:
    plot_phonemes(enc)
    

if __name__=="__main__":
  parser = argparse.ArgumentParser(description="Collect files and normalize.")
  parser.add_argument('-o', '--outdir', type=str, default=os.getcwd()+'/out', \
        help="specify output directory, by default store in ./out - also where vocab is stored")
  parser.add_argument('-a', '--augmenting_dict', type=str, default=None, \
        help="specify dictionary file that contains additional words \
              and their corresponding phonetic breakup")
  parser.add_argument('-i', '--indirs', type=str, nargs='+', \
        help='path of root directory in the tree where txt,scp files are located')
  parser.add_argument('-f', '--files', type=str, nargs='+', \
        help='list of files to be inormalized')
  parser.add_argument('-w', '--keep_words', default=False, action='store_true', \
        help='decide whether to split unknown words into characters or keep them as they are')
  parser.add_argument('-s', '--same_dir', default=False, action='store_true', \
        help='store files where they are located (overrides outdir)')
  parser.add_argument('-p', '--plot', default=False, action='store_true', \
        help='plots final phoneme distribution')
  parser.add_argument('-j', '--jobprefix', type=str, default='all', \
        help="prefix of the output vocab and phoneme files")
  parser.add_argument('-e', '--file_extension', type=str, default='trans.raw', \
        help="file extension type (default : trans.raw)")
  args = parser.parse_args()
  #### Convert text file and get numbers
  print(args)
  run(args)
