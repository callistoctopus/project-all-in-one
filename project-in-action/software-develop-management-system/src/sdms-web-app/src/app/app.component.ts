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
    this.view.subfuncMap.set('dashboard',['function1','function2']);
    this.view.functions.push('business');
    this.view.functionMap.set('business','function1');
    this.view.functions.push('home');
    this.view.functionMap.set('home','function2');
  }
}
