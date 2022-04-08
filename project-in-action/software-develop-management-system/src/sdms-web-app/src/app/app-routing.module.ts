import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FunctionContentComponent } from './function/function-content/function-content.component';
import { Function2Component } from './function/function2/function2.component';

const routes: Routes = [
  { path: 'function1', component: FunctionContentComponent },
  { path: 'function2', component: Function2Component },
  { path: '', redirectTo: '/', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
