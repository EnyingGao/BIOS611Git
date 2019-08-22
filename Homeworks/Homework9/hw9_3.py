import pandas as pd
import numpy as np
np.random.seed(0)

df = pd.DataFrame({'A': np.random.uniform(0,1,20), 'B': np.random.uniform(0,1,20), 'C': np.random.uniform(0,1,20), 'D':np.random.uniform(0,1,20), 'E':np.random.uniform(0,1,20)})

print(df.mean())