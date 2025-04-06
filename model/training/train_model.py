
# Simulated training script for pregnancy risk ML model
import numpy as np
import tensorflow as tf

# Sample data: [age, hemoglobin], label: 1 = high risk, 0 = low risk
X = np.array([
    [17, 10], [36, 10], [25, 12], [30, 11], [19, 9], [40, 10]
], dtype=np.float32)
y = np.array([1, 1, 0, 0, 1, 1], dtype=np.float32)

model = tf.keras.Sequential([
    tf.keras.layers.Input(shape=(2,)),
    tf.keras.layers.Dense(8, activation='relu'),
    tf.keras.layers.Dense(1, activation='sigmoid')
])
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

model.fit(X, y, epochs=20)

# Convert to TFLite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()
with open("../model.tflite", "wb") as f:
    f.write(tflite_model)
