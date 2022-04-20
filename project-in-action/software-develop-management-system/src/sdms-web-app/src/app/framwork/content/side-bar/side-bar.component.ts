import { Component, Input, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';

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
  }

  toggle(func: string) {
    this.view.sideOnClick(func);
  }
}
