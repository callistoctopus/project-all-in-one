import { Component } from '@angular/core';
import { MenuFunction } from './framwork/model/function';
import { ViewConfigularService } from './framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  constructor(public view: ViewConfigularService) {

    this.view.meuns = [{id : 0, icon : 'dashboard', content : '', route : '', child : [1,2], level:0}
                        ,{id : 1, icon : 'image', content : '图像处理', route : 'pic', child : [], level:1}
                        ,{id : 2, icon : 'book', content : 'epub阅读器', route : 'epub', child : [], level:1}
                        ,{id : 3, icon : 'calculate', content : '开发成本计算', route : 'cost_cal', child : [], level:0}];

    this.view.init();
  }

  onClick(){
    this.view.statusMap.set('mouse', this.view.clickCount++);
  }
}
