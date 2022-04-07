# 环境构建
docker run -itd \
    --rm \
    -v /var/work/projects/project-in-action/software-develop-management-system/src:/var/work/src \
    -v /var/work/volumes/config/node/npmrc:/usr/local/etc/npmrc \
    -p 8081:4200 \
    --name sdms-web-app \
    node:lts-alpine

npm install -g @angular/cli
npm install

ng new sdms-web-app
cd sdms-web-app

ng serve --port 4200 --host 0.0.0.0



ng add @angular/material


echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# 生成控件
ng generate component heroes

# 生成服务
ng generate service hero