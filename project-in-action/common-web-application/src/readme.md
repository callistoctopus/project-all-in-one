# 环境构建
docker run -itd \
    --rm \
    -v /var/work/projects/project-in-action/common-web-application/src:/var/work/src \
    -v /var/work/volumes/config/node/npmrc:/usr/local/etc/npmrc \
    -w /var/work/src \
    -p 8081:4200 \
    --name common-web-app \
    node:lts-alpine

npm install -g @angular/cli
npm install

ng new common-web-app
cd common-web-app

ng serve --port 4200 --host 0.0.0.0



ng add @angular/material

npm i ng-devui
import { DevUIModule } from 'ng-devui';
DevUIModule

angular.json

{
  "styles": [
    ...
    "node_modules/ng-devui/devui.min.css"
  ]
}


echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


npm install proton-engine --save
npm install raf-manager --save
npm install stats.js --save

npm install three --save
npm install three.modifiers --save
npm install three.proton.js --save

# 生成控件
ng generate component heroes

# 生成服务
ng generate service hero