
# coding: utf-8

# ## Basic Pandas DataFrame

# In[10]:

from pylab import *
get_ipython().magic(u'matplotlib inline')
import pandas as pd
df = pd.DataFrame( { 'a' : [1, 2, 3, 4], 'b': [ 'w', 'x', 'y', 'z'], 'code':["M","M","F","F"] })


# In[11]:

df


# In[12]:

df.head(2)


# In[13]:

df.tail(2)


# In[14]:

df[1:3]


# In[17]:

df.describe()


# In[18]:

df.apply(np.cumsum)


# In[15]:

grouped = df.groupby('code')
grouped


# In[16]:

grouped.ngroups
grouped.groups.keys()


# Can do other things similar to dply with table manipulation: join, merge, reshape. Also work with time series and catagorical data

# In[ ]:



