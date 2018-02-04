from keras.models import Sequential, load_model
from keras.layers import Dense, Dropout


def train(x_train, y_train):
	model = Sequential()
	model.add(Dense(100, input_shape=(29, )))
	model.add(Dropout(0.25))
	model.add(Dense(40))
	model.add(Dropout(0.25))
	model.add(Dense(30))
	model.add(Dropout(0.25))
	model.add(Dense(1, activation='sigmoid'))
	model.compile(optimizer='adam', loss='mean_squared_error', metrics=['accuracy'])
	model.fit(x_train, y_train, batch_size=32, epochs=10, verbose=2)

	model.save('my_loan_model_final.hd5')


def evaluate(x_test, y_test):
	model = load_model('my_loan_model_final.hd5')
	val = model.evaluate(x_test, y_test, verbose=0)

	return val


def predict(x):
	model = load_model('my_loan_model_final.hd5')
	pred = model.predict_proba(x, batch_size=1)

	return pred
