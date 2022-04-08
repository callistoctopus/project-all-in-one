import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CostCalculateComponent } from './function/component/cost-calculate/cost-calculate.component';
import { DefaultComponent } from './function/component/default/default.component';

const routes: Routes = [
  { path: 'cost_cal', component: CostCalculateComponent },
  { path: 'default', component: DefaultComponent },
  { path: '', redirectTo: '/default', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
