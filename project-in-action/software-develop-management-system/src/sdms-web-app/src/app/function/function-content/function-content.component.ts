import { Component, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-function-content',
  templateUrl: './function-content.component.html',
  styleUrls: ['./function-content.component.css'],
})
export class FunctionContentComponent implements OnInit {
  constructor(public view: ViewConfigularService) {
    
    this.view.log = 'function init';
  }

  ngOnInit(): void {
    // this.view.functions.push('home');
  }
}
