import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import {MatToolbarModule} from '@angular/material/toolbar';
import {MatIconModule} from '@angular/material/icon';
import { HeadBarComponent } from './framwork/head-bar/head-bar.component';
import { SideBarComponent } from './framwork/content/side-bar/side-bar.component';
import { FootBarComponent } from './framwork/foot-bar/foot-bar.component';
import {MatSidenavModule} from '@angular/material/sidenav';
import { ContentComponent } from './framwork/content/content.component';
import { SideContentComponent } from './framwork/content/side-content/side-content.component';
import { FunctionContentComponent } from './function/function-content/function-content.component';
import { SideContentNavComponent } from './framwork/content/side-content-nav/side-content-nav.component';
import { Function2Component } from './function/function2/function2.component';

@NgModule({
  declarations: [
    AppComponent,
    HeadBarComponent,
    SideBarComponent,
    FootBarComponent,
    ContentComponent,
    SideContentComponent,
    FunctionContentComponent,
    SideContentNavComponent,
    Function2Component
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatToolbarModule,
    MatIconModule,
    MatSidenavModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
