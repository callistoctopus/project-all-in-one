import { Component, OnInit } from '@angular/core';

import { ViewConfigularService } from '../service/view-configular/view-configular.service';

@Component({
  selector: 'app-content',
  templateUrl: './content.component.html',
  styleUrls: ['./content.component.css']
})
export class ContentComponent implements OnInit {

  constructor(public view: ViewConfigularService) { }

  ngOnInit(): void {
  }
}
