// Controller for the tab-contact html file

angular.module('tabContact.module', []).controller('TabContactController', function($scope) {

// var deadline = '2016-11-25 18:00:00';


// initializeClock('clockdiv', deadline);

// // To initialize the clock and send the data back to the html
// 		function initializeClock(id, endtime){
// 		  var clock = document.getElementById(id);
		  
// 		  var timeinterval = setInterval(function(){
// 		    var t = getTimeRemaining(endtime);
// 		    clock.innerHTML = 'days: ' + t.days + '<br>' +
// 		                      'hours: '+ t.hours + '<br>' +
// 		                      'minutes: ' + t.minutes + '<br>' +
// 		                      'seconds: ' + t.seconds;
// 		    // daysc.innerHTML = t.seconds;
// 		    if(t.total<=0){
// 		      clearInterval(timeinterval);
// 		    }
// 		  },1000);
// 		}

// // To calculate the remaning time
// 		function getTimeRemaining(endtime){
// 		  var t = Date.parse(endtime) - Date.parse(new Date());
// 		  var seconds = Math.floor( (t/1000) % 60 );
// 		  var minutes = Math.floor( (t/1000/60) % 60 );
// 		  var hours = Math.floor( (t/(1000*60*60)) % 24 );
// 		  var days = Math.floor( t/(1000*60*60*24) );
// 		  return {
// 		    'total': t,
// 		    'days': days,
// 		    'hours': hours,
// 		    'minutes': minutes,
// 		    'seconds': seconds
// 		  };
// 		}

});