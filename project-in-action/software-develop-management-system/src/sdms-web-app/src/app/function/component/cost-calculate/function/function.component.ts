import { Component, Input, OnInit } from '@angular/core';
import { Function } from 'src/app/function/modal/Function';

@Component({
  selector: 'app-function',
  templateUrl: './function.component.html',
  styleUrls: ['./function.component.css']
})
export class FunctionComponent implements OnInit {

  @Input() item?: Function;

  constructor() { }

  ngOnInit(): void {
  }

}
