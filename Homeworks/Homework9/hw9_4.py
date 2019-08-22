import sys
import scipy.stats
import pandas as pd
import numpy as np

def probability(mean, st, value):
	output_pdf = scipy.stats.norm(mean, st).pdf(value)
	output_cdf = scipy.stats.norm(mean, st).cdf(value)
	return output_pdf,output_cdf

mean = int(sys.argv[1])
st = int(sys.argv[2])
value = int(sys.argv[3])

print(probability(mean,st,value))