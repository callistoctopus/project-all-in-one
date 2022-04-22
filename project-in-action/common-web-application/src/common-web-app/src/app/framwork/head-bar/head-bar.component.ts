import { Component, OnInit } from '@angular/core';
import { ViewConfigularService } from '../service/view-configular/view-configular.service';

@Component({
  selector: 'app-head-bar',
  templateUrl: './head-bar.component.html',
  styleUrls: ['./head-bar.component.css']
})
export class HeadBarComponent implements OnInit {

  title = 'sdms-web-app';
  
  constructor(public view:ViewConfigularService) { }

  ngOnInit(): void {
  }

  onToggle(event: any) {
    console.log(event);
  }

}
