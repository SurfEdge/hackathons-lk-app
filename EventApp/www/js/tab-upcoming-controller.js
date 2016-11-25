// Controller for the tab-upcoming html file

angular.module('tabUpcoming.module', [])


// Directive to embed the html file
	.directive('myDirective', function(){
	   return {
 
	   	    scope: {
      		myindex: '='
    },
            template: '<span class="countdown-days"><span class="days" id="ongoing-days">00</span> : </span><span class="countdown-days"><span class="days" id="ongoing-hours">00</span> : </span><span class="countdown-min"><span class="days" id="ongoing-minutes">00</span> : </span><span class="countdown-seconds"><span class="days" id="ongoing-seconds">00</span> </span>', // where myDirective binds to scope.myDirective
    
    link: function(scope, element, attrs){

    	initializeClock();
    	console.log("fd");
     
     // To initialize the clock and send the data back to the html
		function initializeClock(){
			var endtime = "2016-11-25 18:00:00";
			// $scope.initializeClock = function initializeClock(endtime, days, hours, minutes, seconds){
			// console.log("SEconds " + minutes);
		  var days = document.getElementById('ongoing-days');
		  var hours = document.getElementById('ongoing-hours');
		  var minutes = document.getElementById('ongoing-minutes');
		  var seconds = document.getElementById('ongoing-seconds');

		  var timeinterval = setInterval(function(){
		    var t = getTimeRemaining(endtime);

		    days.innerHTML = t.days;
		    hours.innerHTML = t.hours;
		    minutes.innerHTML = t.minutes;
		    seconds.innerHTML = t.seconds;
		    if(t.total<=0){
		      clearInterval(timeinterval);
		    }
		  },1000);
		}


// To calculate the remaning time
		function getTimeRemaining(endtime){
		  var t = Date.parse(endtime) - Date.parse(new Date());
		  var seconds = Math.floor( (t/1000) % 60 );
		  var minutes = Math.floor( (t/1000/60) % 60 );
		  var hours = Math.floor( (t/(1000*60*60)) % 24 );
		  var days = Math.floor( t/(1000*60*60*24) );
		  return {
		    'total': t,
		    'days': days,
		    'hours': hours,
		    'minutes': minutes,
		    'seconds': seconds
		  };
		}


    }
    	};
	  })



// Controller for the module
.controller('TabUpcomingController', function($scope) {

	var jsonObject = '[{"Name" : "Disrupt 2.0 – FutureX", "location" : "University of Colombo School of Computing", "status" : "Hackathon Started", "date" : "NOVEMBER 3RD, 2016" , "exact_time" : "2016-11-25 18:00:00", "views" : "248","cover":"http://hackathons.lk/wp-content/uploads/2016/10/futurex_cover.jpg"},{"Name" : "BeThem Challenge", "location" : "99X Technology", "status" : "Hackathon not Started", "date" : "NOVEMBER 3RD, 2016" , "views" : "100","cover":"http://hackathons.lk/wp-content/uploads/2016/11/bethem_2.jpg"}]';

	// To parst the data and set the data into the scope
	var obj = JSON.parse(jsonObject);
	$scope.upcomingData = obj;

})

;
