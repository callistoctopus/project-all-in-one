import { Component, Input, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-side-bar',
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.css'],
})
export class SideBarComponent implements OnInit {
  constructor(public view: ViewConfigularService) {}

  ngOnInit(): void {
    this.view.log = 'side-bar init';
  }

  toggle(item: string) {
    if (this.view.current_function == item) {
      this.view.showFiller = !this.view.showFiller && this.view.funcs.length > 0;
    } else {
      this.view.showFiller = false;
      this.view.current_function = item;
      this.view.funcs = this.view.subfuncs.get(this.view.current_function)
      this.view.showFiller = this.view.funcs.length > 0;
    }
  }
}
