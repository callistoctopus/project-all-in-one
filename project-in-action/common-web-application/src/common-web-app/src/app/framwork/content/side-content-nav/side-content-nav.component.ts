import { Component, OnInit } from '@angular/core';
import { ViewConfigularService } from '../../service/view-configular/view-configular.service';
import {
  trigger,
  state,
  style,
  animate,
  transition,
  // ...
} from '@angular/animations';

@Component({
  selector: 'app-side-content-nav',
  animations: [
    trigger('openClose', [
      // ...
      state('open', style({
        left:'215px',
        width:(window.innerWidth - 45 - 170) + 'px'
      })),
      state('closed', style({
        left:'45px',
        width:(window.innerWidth - 45) + 'px'
      })),
      transition('open => closed', [
        animate('0.2s')
      ]),
      transition('closed => open', [
        animate('0.2s')
      ]),
    ]),
  ],
  templateUrl: './side-content-nav.component.html',
  styleUrls: ['./side-content-nav.component.css']
})
export class SideContentNavComponent implements OnInit {

  constructor(public view: ViewConfigularService) { }

  ngOnInit(): void {
  }

}
