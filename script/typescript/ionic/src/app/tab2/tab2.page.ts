import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders, HttpParams } from '@angular/common/http';
// import {Stomp} from 'stompjs';
// import {SockJS} from 'sockjs-client';


@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss']
})
export class Tab2Page{
	persons : any[];
	public receivedMessages: string[] = [];

	constructor(private http: HttpClient) { 
		this.persons = [];
	}

	
	sysc = function(){
		
		const person = {
			name:"桂奇",
			phoneNumber:"15669978227"
		}	
		
		var httpOptions = {
		  headers: new HttpHeaders({
			'Content-Type':  'application/x-www-form-urlencoded'
		  })
		};
		
		const params = new HttpParams()
		.set('name', '桂奇')
		.set('phoneNumber', "15669978227");
		
		this.http.post("http://localhost:8080/SkyEmperor/island/syncPerson","name=bar&phoneNumber=moe", httpOptions)
		.subscribe(
			data => {this.persons.push(data);}, 
			error => {alert("ERROR")}
		);
	}
	
	sysct = function(){	

		this.http.get("http://localhost:8080/SkyEmperor/syncPerson/55")
		.subscribe(
			data => {this.persons.push(data);}, 
			error => {alert("ERROR")}
		);
	}
	
	sayMarco = function(){
		// var sockclient = new SockJS('http://localhost:8080/SkyEmperor/island/marcopolo');
		// var stompclient = Stomp.over(sockclient);
		
		// stompclient.connect('guest', 'guest', function(frame) {
			// alert("connected");
			// stompclient.subscribe("/topic/kongzi", handlePolo);
		// });
		
		// function handlePolo(message) {
			// alert(JSON.parse(message.body).message);
		// }
	}
	

}
