import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import { Function } from '../../model/Function';

@Component({
  selector: 'app-function',
  templateUrl: './function.component.html',
  styleUrls: ['./function.component.css']
})
export class FunctionComponent implements OnInit {

  get name(){return this.item.name}
  set name(nn:string){
    this.item.name = nn;
    this.valuechanged.emit();
  }

  get view(){return this.item.view}
  set view(nn:number){
    this.item.view = nn;
    this.valuechanged.emit();
  }

  get table(){return this.item.table}
  set table(nn:number){
    this.item.table = nn;
    this.valuechanged.emit();
  }

  get logic(){return this.item.logic}
  set logic(nn:number){
    this.item.logic = nn;
    this.valuechanged.emit();
  }

  get weight(){return this.item.weight}
  set weight(nn:number){
    this.item.weight = nn;
    this.valuechanged.emit();
  }

  @Input() item!: Function;

  @Input() dataSource?:Function[];

  @Output() valuechanged = new EventEmitter<any>();

  count = 0;

  constructor(private viewc : ViewConfigularService) { }
  ngOnInit(): void {}

}
