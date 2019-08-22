
# coding: utf-8

# # Basic Stat in numpy/scipy

# First we import the relevant libraries  
# And set the random seed

# In[24]:

#import matplotlib
#matplotlib.pyplot.plot(...)

#Note this is the same as
#import pylab
#pylab.plot(...)

#also can do
#import matplotlib.pyplot as plt

#we will do
from pylab import *
get_ipython().magic(u'matplotlib inline')
from scipy import stats
import numpy as np

np.random.seed(7)


# ### One dimensional array

# In[8]:

x = np.array([2,3,1,0])
print x
y1 = np.arange(10)
print y1
y2 = np.arange(2, 3, 0.1)
print y2


# ### Two dimensional array

# In[10]:

a = np.array([[1,2,3],[4,5,6]]) 
print(a.shape)
print(b[0,0])
z = np.zeros((2, 3))
print (z)


# In[20]:

b = np.ones((1,2))
print(b.T) # Transpose
c = np.eye(3)         
print(c)
d = np.reshape(c,[9,1])
print(d)


# ### Array Math

# In[15]:

x = np.array([[1,2],[3,4]], dtype=np.float64)
y = np.array([[5,6],[7,8]], dtype=np.float64)

v1 = np.array([6,7])
v2 = np.array([8, 9])

print(x + y)
print(np.add(x, y))
print(np.sqrt(x))
print(np.dot(v1, v2))


# ### Sparse Matrix

# In[38]:

import scipy.sparse

#create a sparse matrix
n = 100000
x = (np.random.rand(n)*2).astype(int).astype(float) 


# In[39]:

x_csr = scipy.sparse.csr_matrix(x)
x_dok = scipy.sparse.dok_matrix(x.reshape(x_csr.shape))


# ### Simple Statistics

# In[45]:

sample1 = stats.norm.rvs(size=400)
sample2 = stats.norm.rvs(loc=0.15, size=400)


# In[46]:

bins = np.linspace(-3,3,10)
hist(sample1,bins,rwidth=0.5)
hist(sample2,bins,rwidth=0.5, align=u'right')


# In[48]:

stats.ttest_ind(sample1, sample2)


# In[49]:

exp1 = np.exp(sample1)
exp2 = np.exp(sample2)
stats.ttest_ind(exp1, exp2)


# Kolmogorov-Smirnov test (2 sample KS test nonparametric)

# In[50]:

stats.ks_2samp(exp1,exp2)


# ### Many other functionalities
# 
# For example,
# Mathematical optimization (https://docs.scipy.org/doc/scipy/reference/tutorial/optimize.html)  
# Resources for other things https://docs.scipy.org/doc/scipy/reference/tutorial/ , http://scipy-cookbook.readthedocs.io/

# In[52]:

import numpy as np
from scipy.optimize import minimize

def rosen(x):
    """The Rosenbrock function"""
    return sum(100.0*(x[1:]-x[:-1]**2.0)**2.0 + (1-x[:-1])**2.0)

x0 = np.array([1.3, 0.7, 0.8, 1.9, 1.2])
res = minimize(rosen, x0, method='nelder-mead',
                options={'xtol': 1e-8, 'disp': True})
print(res.x)


# In[ ]:



