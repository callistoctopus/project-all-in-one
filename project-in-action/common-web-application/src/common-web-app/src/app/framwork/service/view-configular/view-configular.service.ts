import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { MenuFunction } from '../../model/function';
import { Statu } from '../../model/statu';

@Injectable({
  providedIn: 'root',
})
export class ViewConfigularService {
  public showFiller: boolean = false;

  b = 'b3';

  clickCount = 0;

  meuns: MenuFunction[] = [];

  // 当前选择的主icon
  current_function: MenuFunction = new MenuFunction();

  // 次级菜单icon
  subfuncs: MenuFunction[] = [];

  status: Map<string, Statu> = new Map();

  constructor(private router: Router) {}

  sideOnClick(func: MenuFunction) {
    if (func.level == 1) {
      if (this.current_function.id == func.id) {
        this.showFiller =
          !this.showFiller && func.child != null && func.child.length > 0;
      } else {
        this.current_function = func;
        this.subfuncs = [];
        func.child.forEach((value: number) => {
          let subFunc = this.meuns.find((funct, index) => {
            return funct.id == value;
          });
          if (subFunc) {
            this.subfuncs.push(subFunc);
          }
        });
        this.showFiller = func.child != null && func.child.length > 0;
      }
    }

    if (func.child == null || func.child.length <= 0 || func.route != '') {
      this.router.navigateByUrl(func.route);
      this.showCurrentFunc(func);
    }
  }

  to(route: string) {
    if (route != '') {
      this.router.navigateByUrl(route);
    }
  }

  private showCurrentFunc(func:MenuFunction) {
    this.status.set('current_func', {
      id: -1,
      icon: 'radio_button_checked',
      content: func.content,
      level: 1,
    });
  }
}
