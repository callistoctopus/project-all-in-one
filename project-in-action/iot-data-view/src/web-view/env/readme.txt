docker run -itd \
    -v /var/work:/var/work \
    -p 8081:4200 \
    --name node \
    node:lts-alpine

npm install -g @angular/cli

ng new data-view

cd data-view

ng serve --port 4200 --host 0.0.0.0