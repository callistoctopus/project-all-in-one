import { Component, OnInit } from '@angular/core';
import { ViewConfigularService } from '../service/view-configular/view-configular.service';

@Component({
  selector: 'app-foot-bar',
  templateUrl: './foot-bar.component.html',
  styleUrls: ['./foot-bar.component.css']
})
export class FootBarComponent implements OnInit {

  title = 'sdms-web-app';
  
  constructor(public view:ViewConfigularService) { }

  ngOnInit(): void {
  }

}
