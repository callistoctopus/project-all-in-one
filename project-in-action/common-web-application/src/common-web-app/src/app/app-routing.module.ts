import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CostCalculateComponent } from './function/cost-calculate/cost-calculate.component';
import { DefaultComponent } from './function/default/default.component';
import { EpubComponent } from './function/epub/epub.component';
import { PicComponent } from './function/pic/pic.component';

const routes: Routes = [
  { path: 'cost_cal', component: CostCalculateComponent },
  { path: 'default', component: DefaultComponent },
  { path: 'pic', component: PicComponent },
  { path: 'epub', component: EpubComponent },
  { path: '', redirectTo: '/default', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
