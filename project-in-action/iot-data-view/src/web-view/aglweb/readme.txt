# 环境构建
docker run -itd \
    -v /var/work/projects/project-in-action/iot-data-view/src/web-view/aglweb:/var/work/aglweb \
    -v /var/work/volumes/config/node/npmrc:/usr/local/etc/npmrc \
    -p 8081:4200 \
    --name web-view-ng \
    node:lts-alpine

npm install -g @angular/cli
ng serve --port 4200 --host 0.0.0.0


# 生成控件
ng generate component heroes