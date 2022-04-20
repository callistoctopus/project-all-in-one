// import { Component, OnInit } from '@angular/core';
import { DOCUMENT } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { ChangeDetectorRef, Component, Inject, OnInit, ViewChild } from '@angular/core';
import {
  IFileOptions,
  IUploadOptions,
  SingleUploadComponent,
} from 'ng-devui/upload';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-pic',
  templateUrl: './pic.component.html',
  styleUrls: ['./pic.component.css'],
})
export class PicComponent implements OnInit {
  images: File[] = [];

  additionalParameter = {
    name: 'tom',
    age: 11,
  };

  fileOptions: IFileOptions = {
    multiple: false,
    accept: '.png,.jpg',
  };

  uploadOptions: IUploadOptions = {
    uri: '/upload',
    headers: {},
    additionalParameter: this.additionalParameter,
    maximumSize: 0.5,
    method: 'POST',
    fileFieldName: 'dFile',
    withCredentials: true,
    responseType: 'json',
  };

  constructor(private tt:ChangeDetectorRef) {
    // this.beforeUploadFn = this.beforeUpload2.bind(this);
  }

  ngOnInit(): void {}

  fileSelected(file: File) {
    var that = this;
    var reader = new FileReader();
    reader.onload = function (aImg) {
      return function (e: { target: { result: any; }; }) {
        that.images.push(e.target.result);
        that.tt.markForCheck();
        that.tt.detectChanges();
      };
    };
    reader.readAsDataURL(file);
  }
}
