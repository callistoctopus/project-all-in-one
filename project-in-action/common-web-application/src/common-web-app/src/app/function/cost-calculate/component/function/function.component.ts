import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import { Function } from '../../model/Function';
import { TableWidthConfig } from 'ng-devui/data-table';

@Component({
  selector: 'app-function',
  templateUrl: './function.component.html',
  styleUrls: ['./function.component.css']
})
export class FunctionComponent implements OnInit {

  displayedColumns: string[] = ['name', 'view', 'table', 'logic', 'weight'];
  // dataSource = ELEMENT_DATA;

  // get name(){return this.item.name}
  // set name(nn:string){
  //   this.item.name = nn;
  //   this.valuechanged.emit();
  // }

  // get view(){return this.item.view}
  // set view(nn:number){
  //   this.item.view = nn;
  //   this.valuechanged.emit();
  // }

  // get table(){return this.item.table}
  // set table(nn:number){
  //   this.item.table = nn;
  //   this.valuechanged.emit();
  // }

  // get logic(){return this.item.logic}
  // set logic(nn:number){
  //   this.item.logic = nn;
  //   this.valuechanged.emit();
  // }

  // get weight(){return this.item.weight}
  // set weight(nn:number){
  //   this.item.weight = nn;
  //   this.valuechanged.emit();
  // }

  @Input() item!: Function[];

  @Output() valuechanged = new EventEmitter<any>();

  count = 0;

  dataTableOptions = {
    columns: [
      {
        field: 'id',
        header: 'No',
        fieldType: 'text'
      },
      {
        field: 'name',
        header: '功能名',
        fieldType: 'text'
      },
      {
        field: 'view',
        header: '页面',
        fieldType: 'text'
      },
      {
        field: 'table',
        header: '数据库表',
        fieldType: 'date'
      },
      {
        field: 'logic',
        header: '逻辑',
        fieldType: 'date'
      },
      {
        field: 'weight',
        header: '权重',
        fieldType: 'date'
      },
    ]
  };

  tableWidthConfig: TableWidthConfig[] = [
    // {
    //   field: '#',
    //   width: '15px'
    // },
    {
      field: 'id',
      width: '100px'
    },
    {
      field: 'name',
      width: '100px'
    },
    {
      field: 'view',
      width: '100px'
    },
    {
      field: 'table',
      width: '100px'
    },
    {
      field: 'logic',
      width: '100px'
    },
    {
      field: 'weight',
      width: '100px'
    }
  ];

  constructor(private viewc : ViewConfigularService) { }
  ngOnInit(): void {}

}
