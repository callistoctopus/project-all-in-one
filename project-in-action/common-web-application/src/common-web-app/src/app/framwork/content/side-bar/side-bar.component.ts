import { Component, Input, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';
import { MenuFunction } from '../../model/function';

@Component({
  selector: 'app-side-bar',
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.css'],
})
export class SideBarComponent implements OnInit {
  count = 0;
  constructor(
    public view: ViewConfigularService
  ) {}

  ngOnInit(): void {
    this.view.statusMap.set('日志','side-bar init');
  }

  toggle(func: MenuFunction) {
    this.view.sideOnClick(func);
  }
}
