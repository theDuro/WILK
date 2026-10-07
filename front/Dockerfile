# Obraz frontu – serwuje gotowy build Reacta (front/build) przez "serve".
# Odtworzony na podstawie historii obrazu theduro/new-front-21.04 (docker/front_history.txt).
FROM node:18-alpine

WORKDIR /app

RUN npm install -g serve

COPY build/ ./build

EXPOSE 8080

# -s = tryb SPA (nieznane sciezki -> index.html), -l = port
CMD ["serve", "-s", "build", "-l", "8080"]
