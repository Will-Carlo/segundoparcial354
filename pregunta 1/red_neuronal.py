import numpy as np

# Definir la función de activación (por ejemplo, sigmoide)
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# Cargar el dataset Iris
from sklearn.datasets import load_iris
iris = load_iris()
X = iris.data
y = iris.target

# Dividir los datos en conjuntos de entrenamiento y prueba
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)

# Inicializar los parámetros de la red neuronal
input_size = X.shape[1]
hidden_size = 10
output_size = len(np.unique(y))
learning_rate = 0.1

# Inicializar los pesos y sesgos de forma aleatoria
np.random.seed(0)
W1 = np.random.randn(input_size, hidden_size)
b1 = np.zeros(hidden_size)
W2 = np.random.randn(hidden_size, output_size)
b2 = np.zeros(output_size)

# Entrenamiento de la red neuronal
for epoch in range(1000):
    # Propagación hacia adelante
    hidden_layer = sigmoid(np.dot(X_train, W1) + b1)
    output_layer = sigmoid(np.dot(hidden_layer, W2) + b2)

    # Cálculo del error
    error = y_train.reshape(-1, 1) - output_layer

    # Propagación hacia atrás y actualización de los pesos y sesgos
    d_output = error * output_layer * (1 - output_layer)
    d_hidden = np.dot(d_output, W2.T) * hidden_layer * (1 - hidden_layer)

    W2 += learning_rate * np.dot(hidden_layer.T, d_output)
    b2 += learning_rate * np.sum(d_output, axis=0)
    W1 += learning_rate * np.dot(X_train.T, d_hidden)
    b1 += learning_rate * np.sum(d_hidden, axis=0)

# Evaluación del modelo
hidden_layer = sigmoid(np.dot(X_test, W1) + b1)
predicted = np.argmax(sigmoid(np.dot(hidden_layer, W2) + b2), axis=1)
accuracy = np.mean(predicted == y_test) * 100
print(f"Accuracy: {accuracy}%")
