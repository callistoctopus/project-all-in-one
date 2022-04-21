import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { MatToolbarModule } from '@angular/material/toolbar';
import { MatIconModule } from '@angular/material/icon';
import { MatCardModule } from '@angular/material/card';
import { MatTableModule } from '@angular/material/table';
import { HeadBarComponent } from './framwork/head-bar/head-bar.component';
import { SideBarComponent } from './framwork/content/side-bar/side-bar.component';
import { FootBarComponent } from './framwork/foot-bar/foot-bar.component';
import { MatSidenavModule } from '@angular/material/sidenav';
import { ContentComponent } from './framwork/content/content.component';
import { SideContentComponent } from './framwork/content/side-content/side-content.component';
import { SideContentNavComponent } from './framwork/content/side-content-nav/side-content-nav.component';
import { CostCalculateComponent } from './function/cost-calculate/cost-calculate.component';
import { DefaultComponent } from './function/default/default.component';
import { FunctionComponent } from './function/cost-calculate/component/function/function.component';
import { FunctionCodeDefComponent } from './function/cost-calculate/component/function-code-def/function-code-def.component';
import { QualityIndexComponent } from './function/cost-calculate/component/quality-index/quality-index.component';
import { DevUIModule } from 'ng-devui';
import { CommonModule } from '@angular/common';
import { PicComponent } from './function/pic/pic.component';
import { EpubComponent } from './function/epub/epub.component';
import { AuthComponent } from './function/auth/auth.component';

@NgModule({
  declarations: [
    AppComponent,
    HeadBarComponent,
    SideBarComponent,
    FootBarComponent,
    ContentComponent,
    SideContentComponent,
    SideContentNavComponent,
    CostCalculateComponent,
    DefaultComponent,
    FunctionComponent,
    FunctionCodeDefComponent,
    QualityIndexComponent,
    PicComponent,
    EpubComponent,
    AuthComponent,
  ],
  imports: [
    FormsModule,
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatToolbarModule,
    MatIconModule,
    MatSidenavModule,
    MatCardModule,
    MatTableModule,
    DevUIModule,
    CommonModule
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
