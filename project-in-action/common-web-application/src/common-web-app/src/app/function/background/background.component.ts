import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import { B } from './component/b';
import {B1} from './component/b1';
import { B2 } from './component/b2';
import { B3 } from './component/b3';

@Component({
  selector: 'app-background',
  templateUrl: './background.component.html',
  styleUrls: ['./background.component.css']
})

export class BackgroundComponent implements OnInit , OnDestroy{

  @Input() b:string = '';

  bo = '';

  static backgrounds = [];

  static i = 0;

  constructor(private view:ViewConfigularService) {
    BackgroundComponent.backgrounds.push(new B1());
    BackgroundComponent.backgrounds.push(new B2());
    BackgroundComponent.backgrounds.push(new B3());
  }

  ngOnDestroy(): void {
    // BackgroundComponent.backgrounds.find((value) => { return value.id == this.b }).destroy();
  }

  ngOnInit(): void {
    BackgroundComponent.backgrounds.find((value) => { return value.id == this.b }).init();
    this.bo = this.b;
  }

  ngOnChanges(){
    // BackgroundComponent.backgrounds.find((value) => { return value.id == this.bo }).destroy();
    BackgroundComponent.backgrounds.find((value) => { return value.id == this.b }).init();
    // new B3().init
    this.bo = this.b;
  }
}
