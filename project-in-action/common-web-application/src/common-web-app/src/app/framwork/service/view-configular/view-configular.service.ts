import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ViewConfigularService {

  public showFiller: boolean = false;

  clickCount = 0;

  // 主菜单icon
  functions: string[] = [];

  // 当前选择的主icon
  current_function = '';

  // 主菜单路由
  functionMap = new Map();

  // 次级菜单icon
  subfuncs: string[] = [];

  // 当前选择的次级菜单
  current_subfunc = '';

  // 次级菜单路由 
  subfuncMap = new Map();

  statusMap = new Map();

  constructor(private router: Router) {
  }

  sideOnClick(func:string){
    if (this.current_function == func) {
      this.showFiller =
        !this.showFiller && this.subfuncs != null && this.subfuncs.length > 0;
    } else {
      this.current_function = func;
      this.subfuncs = this.subfuncMap.get(this.current_function);
      this.showFiller =
        this.subfuncs != null && this.subfuncs.length > 0;
    }

    if (this.subfuncs == null || this.subfuncs.length <= 0) {
      this.router.navigateByUrl(this.functionMap.get(func));
    }
  }
}
