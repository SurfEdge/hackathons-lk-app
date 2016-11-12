// Controller for the tab-upcoming html file

angular.module('tabUpcoming.module', []).controller('TabUpcomingController', function($scope) {



var jsonObject = '{"Name" : "Disrupt 2.0 – FutureX", "location" : "University of Colombo School of Computing", "status" : "Hackathon Started", "date" : "NOVEMBER 3RD, 2016" , "views" : "248"}';

console.log(jsonObject);
var obj = JSON.parse(jsonObject);
	$scope.upcomingData = obj;
	// 
	// for (var i =0; i<obj.length; i++) {
	// 	$scope.upcomingData[i] = obj[i];
	// }

	// console.log(upcomingData[1]);
});