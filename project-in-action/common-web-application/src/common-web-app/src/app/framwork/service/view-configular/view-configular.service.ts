import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { MenuFunction } from '../../model/function';

@Injectable({
  providedIn: 'root',
})
export class ViewConfigularService {
  public showFiller: boolean = false;

  clickCount = 0;

  meuns: MenuFunction[] = [];

  menusMap: Map<number, MenuFunction> = new Map<number, MenuFunction>();

  // 主菜单icon
  // functions: string[] = [];
  mainfuncs: MenuFunction[] = [];

  // 当前选择的主icon
  current_function = -1;

  // 次级菜单icon
  subfuncs: MenuFunction[] = [];

  // 当前选择的次级菜单
  // current_subfunc = '';

  statusMap = new Map();

  constructor(private router: Router) {}

  init() {
    this.meuns.forEach((value) => {
      this.menusMap.set(value.id, value);
      if (value.level == 0) {
        this.mainfuncs.push(value);
      }
    });
  }

  sideOnClick(func: MenuFunction) {
    if ((func.level == 0)) {
      if (this.current_function == func.id) {
        this.showFiller =
          !this.showFiller && func.child != null && func.child.length > 0;
      } else {
        this.current_function = func.id;
        this.subfuncs = [];
        func.child.forEach((value: number) => {
          const subFunc = this.menusMap.get(value);
          if (subFunc) {
            this.subfuncs.push(subFunc);
          }
        });
        this.showFiller = func.child != null && func.child.length > 0;
      }
    }

    if (func.child == null || func.child.length <= 0 || func.route != '') {
      this.router.navigateByUrl(func.route);
    }
  }
}
