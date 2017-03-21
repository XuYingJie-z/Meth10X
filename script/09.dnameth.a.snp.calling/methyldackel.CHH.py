import sys

# python methydackel.CHH.py sample_CHH g_CHH o_CHH sample 

# track type="bedGraph" description="/home/phuluu/data/WGBS10X_new/Prostate_Brain/called/Adultbrain_bis_2_CEGX/Adultbrain_bis_2_CEGX.MD.strands CHH methylation levels"
# chr1	54691	54692	0	0	1
# chr1	54692	54693	0	0	1
# chr1	54693	54694	0	0	1
# arg
ncol = 6
if not len(sys.argv) == 5:
	print "Missing inputs either reference CHH strands or CHH strands sample or output file path"
	sys.exit()

# sys.argv[1] = "/home/phuluu/data/WGBS10X_new/Prostate_Brain/called/Adultbrain_bis_2_CEGX/Adultbrain_bis_2_CEGX.MD.strands_CHH.5.bedGraph"
sample_CHH = sys.argv[1] 
a = open(sample_CHH)

la = a.next()
las = la.strip().split("\t")
while(len(las) != ncol):
	la = a.next()
	las = la.strip().split("\t")

# sys.argv[2] = "/home/phuluu/Projects/WGBS10X_new/V02/annotations/hg19/hg19.CHH.strands.100.bed"
g_CHH = sys.argv[2]
g = open(g_CHH)

# sys.argv[3] = "/home/phuluu/data/WGBS10X_new/Prostate_Brain/called/Adultbrain_bis_2_CEGX/Adultbrain_bis_2_CEGX.MD.strands_CHH.tsv"
o_CHH = sys.argv[3]

# sys.argv[4] = "Adultbrain_bis_2_CEGX"
sample = sys.argv[4]

O = open(o_CHH, 'w')
line = "#chr" + "\t" + "position" + "\t" + "strand" + "\t" + sample + ".C" + "\t" + sample + ".cov" + "\n"
O.write(line)

for lg in g:
	lgs = lg.strip().split("\t")
	if (lgs[0] == las[0]) and (lgs[1] == las[1]):
		line = lgs[0] + "\t" + lgs[1] + "\t" + lgs[5] + "\t" + las[4] + "\t" + str(int(las[4]) + int(las[5])) + "\n"
		O.write(line)
		las = "NoNo"
		try:
			while(len(las) != ncol):
				la = a.next()
				las = la.strip().split("\t")
		except:
			las = 'NoNo'
	else:
		line = lgs[0] + "\t" + lgs[1] + "\t" + lgs[5] + "\t" + "0" + "\t" + "0" + "\n"
		O.write(line)
O.close()
a.close()
g.close()


