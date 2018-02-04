# import pandas as pd
import numpy as np
import neural_net_loan


print("reading csv...")
df = pd.read_csv('train_home_loan.csv', engine='c')
df = df.sample(frac=1).reset_index(drop=True)
print("done\n")
y = np.array(df.Returned)
x = np.array(df.drop(['Returned'], axis=1))

x_train = x[:30000]
y_train = y[:30000]
x_test = x[30000:, :]
y_test = y[30000:]

print("NN training...")
neural_net.train(x_train, y_train)

shit = np.array([[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]])
print("NN Testing...")
print(neural_net_loan.predict(shit))
