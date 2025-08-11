# Use a supported Node.js version (20+)
FROM node:20-alpine

# Set working directory
WORKDIR /reddit-clone

# Copy package.json & lock file first (cache install step)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your app
COPY . .

# Expose the dev server port
EXPOSE 3000

# Start in development mode
CMD ["npm", "run", "dev"]

