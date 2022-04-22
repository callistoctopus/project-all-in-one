import { Component, OnInit } from '@angular/core';
import {B1} from './component/b1';

@Component({
  selector: 'app-background',
  templateUrl: './background.component.html',
  styleUrls: ['./background.component.css']
})

export class BackgroundComponent implements OnInit {

  background;

  constructor() {}

  ngOnInit(): void {
    this.background = new B1();
    this.background.init();
  }
}
