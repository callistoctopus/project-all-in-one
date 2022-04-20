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
    // this.view.functions.push('dashboard');
    this.view.meuns = [{id : 0, icon : 'dashboard', content : '', route : '', child : [1,2], level:0}
                          ,{id : 1, icon : 'business', content : '功能1', route : '', child : [], level:1}
                          ,{id : 2, icon : 'home', content : '功能功能2', route : '', child : [], level:1}
                          ,{id : 3, icon : 'calculate', content : '', route : 'cost_cal', child : [], level:0}];
    // this.view.functions.push({});
    // this.view.subfuncMap.set('dashboard',['image','']);

    // this.view.functions.push('business');
    // this.view.functionMap.set('business','');

    // this.view.functions.push('home');
    // this.view.functionMap.set('home','');

    // this.view.functions.push('calculate');
    // this.view.functionMap.set('calculate','cost_cal');
    this.view.init();
  }

  onClick(){
    this.view.statusMap.set('点击计数', this.view.clickCount++);
  }
}
