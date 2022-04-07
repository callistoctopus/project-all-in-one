import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FunctionContentComponent } from './function-content/function-content.component';

const routes: Routes = [
  { path: 'function', component: FunctionContentComponent },
  { path: '', redirectTo: '/', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
