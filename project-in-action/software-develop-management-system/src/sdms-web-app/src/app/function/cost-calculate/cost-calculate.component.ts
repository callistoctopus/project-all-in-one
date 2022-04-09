import { Component, OnInit, SimpleChanges } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import { Function } from './model/Function';
import { FunctionCodeDef } from './model/FunctionCodeDef';

@Component({
  selector: 'app-cost-calculate',
  templateUrl: './cost-calculate.component.html',
  styleUrls: ['./cost-calculate.component.css'],
})
export class CostCalculateComponent implements OnInit {
  functions: Function[] = [];

  funcCode: FunctionCodeDef = { view: 0, table: 0, logic: 0, weight: 0 };

  cost: number = 0;

  constructor(private view: ViewConfigularService) {}

  ngOnInit(): void {}

  add() {
    this.functions.push(new Function());
  }

  onChanged(result: boolean) {
    this.cost = 0;
    for (const item of this.functions) {
      this.cost =
        this.cost +
        +item.view * this.funcCode.view +
        +item.table * this.funcCode.table +
        +item.logic * this.funcCode.logic +
        +item.weight * this.funcCode.weight;
    }
  }
}
