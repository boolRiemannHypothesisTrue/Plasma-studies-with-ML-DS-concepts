# %% [markdown]
# # Time Series Analysis with TensorFlow
# This notebook demonstrates how to use TensorFlow for time series analysis. We'll:
# 1. Generate synthetic time series data (sine wave with noise).
# 2. Build a neural network to denoise the data.
# 3. Train the model and evaluate its performance.

# %% [markdown]
# ## 1. Import Libraries

# %%
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Conv1D, MaxPooling1D, UpSampling1D

# %% [markdown]
# ## 2. Generate Synthetic Data
# We'll create a noisy sine wave as our synthetic time series.

# %%
# Generate a sine wave with noise
np.random.seed(42)
timesteps = 1000
time = np.arange(0, timesteps, 1)
signal = np.sin(2 * np.pi * 0.01 * time)  # Sine wave with frequency 0.01 Hz
noise = 0.5 * np.random.normal(size=timesteps)  # Gaussian noise
noisy_signal = signal + noise

# Plot the data
plt.figure(figsize=(10, 4))
plt.plot(time, signal, label="Clean Signal", color="blue")
plt.plot(time, noisy_signal, label="Noisy Signal", color="red", alpha=0.6)
plt.title("Synthetic Time Series Data")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.legend()
plt.show()

# %% [markdown]
# ## 3. Prepare Data for Training
# We'll split the data into training and testing sets and create overlapping windows for the time series.

# %%
# Create overlapping windows
def create_sequences(data, window_size):
    X = []
    for i in range(len(data) - window_size):
        X.append(data[i:i+window_size])
    return np.array(X)

# Parameters
window_size = 50
X_train = create_sequences(noisy_signal, window_size)
y_train = create_sequences(signal, window_size)

# Reshape for Conv1D input
X_train = X_train.reshape((X_train.shape[0], X_train.shape[1], 1))
y_train = y_train.reshape((y_train.shape[0], y_train.shape[1], 1))

print(f"Training data shape: {X_train.shape}")

# %% [markdown]
# ## 4. Build the Neural Network
# We'll use a **1D Convolutional Autoencoder** for denoising.

# %%
# %% Build the Neural Network
model = Sequential([
    # Encoder
    Conv1D(32, 3, activation='relu', padding='same', input_shape=(window_size, 1)),
    MaxPooling1D(2, padding='same'),
    Conv1D(16, 3, activation='relu', padding='same'),
    MaxPooling1D(2, padding='same'),
    
    # Decoder
    Conv1D(16, 3, activation='relu', padding='same'),
    UpSampling1D(2),
    Conv1D(32, 3, activation='relu', padding='same'),
    UpSampling1D(2),
    Conv1D(1, 3, activation='linear', padding='valid')  # Key fix: padding='valid'
])

model.compile(optimizer='adam', loss='mse')
model.summary()

# %% Train the Model
history = model.fit(X_train, y_train, epochs=50, batch_size=32, validation_split=0.2)

# Plot training loss
plt.figure(figsize=(8, 4))
plt.plot(history.history['loss'], label='Training Loss')
plt.plot(history.history['val_loss'], label='Validation Loss')
plt.title('Training and Validation Loss')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()

# %% [markdown]
# %% [markdown]
# ## 6. Denoise the Signal

# %%
# Predict on the training data
denoised_windows = model.predict(X_train)  # Shape: (950, 50, 1)

# Reconstruct the full denoised signal by averaging overlapping windows
denoised_signal = np.zeros(len(signal))
overlap_counts = np.zeros(len(signal))

for i in range(len(denoised_windows)):
    start_idx = i
    end_idx = i + window_size
    denoised_signal[start_idx:end_idx] += denoised_windows[i].flatten()
    overlap_counts[start_idx:end_idx] += 1

# Avoid division by zero
overlap_counts[overlap_counts == 0] = 1
denoised_signal = denoised_signal / overlap_counts

# Trim to match the original signal length
denoised_signal = denoised_signal[:len(signal)]

# Plot the results
plt.figure(figsize=(12, 6))
plt.plot(time, signal, label="Clean Signal", color="blue")
plt.plot(time, noisy_signal, label="Noisy Signal", color="red", alpha=0.4)
plt.plot(time, denoised_signal, label="Denoised Signal", color="green", linewidth=2)
plt.title("Denoised Time Series")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.legend()
plt.show()
# %% [markdown]
# ## 7. Evaluate Performance
# Calculate the Mean Squared Error (MSE) between the clean signal and the denoised signal.

# %%
from sklearn.metrics import mean_squared_error
denoised_signal = denoised_signal[window_size:]
# Calculate MSE
mse = mean_squared_error(signal[window_size:], denoised_signal)
print(f"Mean Squared Error (MSE): {mse:.4f}")

# %% [markdown]
# ## Conclusion
# - The neural network successfully denoised the synthetic time series.
# - The MSE metric quantifies the performance of the model.
# - This approach can be extended to real-world time series data (e.g., Langmuir probe measurements).
