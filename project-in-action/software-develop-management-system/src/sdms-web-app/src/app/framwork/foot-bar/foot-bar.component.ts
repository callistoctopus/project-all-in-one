import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-foot-bar',
  templateUrl: './foot-bar.component.html',
  styleUrls: ['./foot-bar.component.css']
})
export class FootBarComponent implements OnInit {

  title = 'sdms-web-app';
  
  constructor() { }

  ngOnInit(): void {
  }

}
