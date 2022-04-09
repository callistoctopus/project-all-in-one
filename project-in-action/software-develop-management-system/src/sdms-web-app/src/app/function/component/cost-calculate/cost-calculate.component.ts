import { Component, OnInit, SimpleChanges } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import { Function } from '../../modal/Function';

@Component({
  selector: 'app-cost-calculate',
  templateUrl: './cost-calculate.component.html',
  styleUrls: ['./cost-calculate.component.css'],
})
export class CostCalculateComponent implements OnInit {
  functions: Function[] = [];

  cost : number = 0;

  constructor(private view : ViewConfigularService) {}

  ngOnInit(): void {}

  add(){
    this.functions.push(new Function());
  }

  onChanged(result:boolean) {
    this.cost = 0;
    for(const item of this.functions){
      this.cost = this.cost + +item.view  + +item.table  + +item.logic  + +item.weight;
    }
  }
}
