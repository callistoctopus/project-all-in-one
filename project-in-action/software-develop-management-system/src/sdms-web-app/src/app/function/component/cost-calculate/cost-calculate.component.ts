import { Component, OnInit } from '@angular/core';
import { Function } from '../../modal/Function';

@Component({
  selector: 'app-cost-calculate',
  templateUrl: './cost-calculate.component.html',
  styleUrls: ['./cost-calculate.component.css'],
})
export class CostCalculateComponent implements OnInit {
  functions: Function[] = [
    { id: 1, name: 'A', view: 0, table: 0, logic: 0, weight: 1 },
    { id: 2, name: 'b', view: 0, table: 0, logic: 0, weight: 1 },
    { id: 3, name: 'C', view: 0, table: 0, logic: 0, weight: 1 },
    { id: 4, name: 'd', view: 0, table: 0, logic: 0, weight: 1 },
  ];

  // item : Function = { id: 1, name: '', view: 0, table: 0, logic: 0, weight: 1 };

  constructor() {}

  ngOnInit(): void {}
  add(){
    this.functions.push(new Function());
  }
}
