import { Component } from '@angular/core';
import { ViewConfigularService } from './framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  constructor(public view: ViewConfigularService) {
    this.view.functions.push('dashboard');
    this.view.subfuncMap.set('dashboard',['image','']);

    this.view.functions.push('business');
    this.view.functionMap.set('business','');

    this.view.functions.push('home');
    this.view.functionMap.set('home','');

    this.view.functions.push('calculate');
    this.view.functionMap.set('calculate','cost_cal');
  }

  onClick(){
    this.view.statusMap.set('点击计数', this.view.clickCount++);
  }
}
