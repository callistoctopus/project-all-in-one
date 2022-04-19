import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FunctionCodeDef } from '../../model/FunctionCodeDef';

@Component({
  selector: 'app-function-code-def',
  templateUrl: './function-code-def.component.html',
  styleUrls: ['./function-code-def.component.css']
})
export class FunctionCodeDefComponent implements OnInit {

  @Input() funcCode!:FunctionCodeDef;

  @Output() valuechanged = new EventEmitter<any>();

  get view(){return this.funcCode.view}
  set view(nn:number){
    this.funcCode.view = nn;
    this.valuechanged.emit();
  }

  get table(){return this.funcCode.table}
  set table(nn:number){
    this.funcCode.table = nn;
    this.valuechanged.emit();
  }

  get logic(){return this.funcCode.logic}
  set logic(nn:number){
    this.funcCode.logic = nn;
    this.valuechanged.emit();
  }

  get weight(){return this.funcCode.weight}
  set weight(nn:number){
    this.funcCode.weight = nn;
    this.valuechanged.emit();
  }

  constructor() { }

  ngOnInit(): void {
  }

}
