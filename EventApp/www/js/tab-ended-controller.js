// Controller for the tab-ended html file

angular.module('tabEnded.module', []).controller('TabEndedController', function($scope) {

var jsonObject = '[{"Name" : "Disrupt 2.0 – FutureX", "location" : "University of Colombo School of Computing", "status" : "Hackathon Started", "date" : "NOVEMBER 3RD, 2016" , "views" : "248","cover":"http://hackathons.lk/wp-content/uploads/2016/10/futurex_cover.jpg"},{"Name" : "BeThem Challenge", "location" : "99X Technology", "status" : "Hackathon not Started", "date" : "NOVEMBER 3RD, 2016" , "views" : "100","cover":"http://hackathons.lk/wp-content/uploads/2016/11/bethem_2.jpg"}]';

	// To parst the data and set the data into the scope
	var obj = JSON.parse(jsonObject);
	$scope.endedHackthonData = obj;

});