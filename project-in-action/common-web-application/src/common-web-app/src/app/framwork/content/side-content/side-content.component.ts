import { Component, Input, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import {
  trigger,
  state,
  style,
  animate,
  transition,
  // ...
} from '@angular/animations';
import { MenuFunction } from '../../model/function';

@Component({
  selector: 'app-side-content',
  animations: [
    trigger('openClose', [
      // ...
      state('open', style({
        width: '170px'
      })),
      state('closed', style({
        width: '0px'
      })),
      transition('open => closed', [
        animate('0.2s')
      ]),
      transition('closed => open', [
        animate('0.2s')
      ]),
    ]),
  ],
  templateUrl: './side-content.component.html',
  styleUrls: ['./side-content.component.css']
})

export class SideContentComponent implements OnInit {
  constructor(public view: ViewConfigularService) { }

  ngOnInit(): void {
  }

  toggle(func: MenuFunction) {
    this.view.sideOnClick(func);
  }
}
