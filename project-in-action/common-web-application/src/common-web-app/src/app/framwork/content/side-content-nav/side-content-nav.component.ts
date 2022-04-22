import { Component, HostListener, OnInit } from '@angular/core';
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
        width:"{{divWidthOpened}}px"
      }), { params: { divWidthOpened: window.innerWidth - 45 - 170 } }),
      state('closed', style({
        left:'45px',
        width:"{{divWidthClosed}}px"
      }), { params: { divWidthClosed: window.innerWidth - 45 } }),
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

  divWidthOpened = window.innerWidth - 45 - 170;
  divWidthClosed = window.innerWidth - 45;

  @HostListener('window:resize', ['$event']) 
  public onResize = () => {
    this.divWidthOpened = window.innerWidth - 45 - 170;
    this.divWidthClosed = window.innerWidth - 45;
  }

  constructor(public view: ViewConfigularService) { }

  ngOnInit(): void {
  }

}

window.addEventListener('resize',function(){
  console.log(window.innerWidth);
})
