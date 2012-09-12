var Geometry = (function() {

	var coords = function(xCenter, yCenter, theta, radius) {
		
		var rad = (90 + theta) * Math.PI / 180;

		return {
			x: xCenter + radius * Math.cos(rad),
			y: yCenter + radius * Math.sin(rad)
		}
	}

	return {
		coords:coords
	}
})();

var Graphics = (function() {

	var canvas;

	var init = function(element) {

		canvas = Raphael(element, 280, 200);

		Raphael.fn.arc = function(xCenter, yCenter, theta, radius) {

	        var coords = Geometry.coords(xCenter, yCenter, theta, radius);
	        var x = coords.x;
	        var y = coords.y;

	        if(theta == 360) {
	        	x = xCenter + 0.01;
	        	y = yCenter + radius;
	        }

	        return this.path([
	        	['M', xCenter, yCenter + radius],
	           	['A', radius, radius, 0, +(theta > 180), 1, x, y]
	        ]);
		}
	}

	var renderDonutChart = function(scoreOne, scoreTwo) { 

		var total = scoreOne + scoreTwo;
		var theta = arcAngle(scoreOne, total);

		//border
		drawCircle(135, '#fff');
		//base
		drawArc(360, 113, 40, '#c6c6c6');
		//separator
		if(scoreOne != 100 && scoreTwo != 100) {
			drawArc(theta+1, 113, 40, '#fff');
		}
		//first participant score
		drawArc(theta, 113, 40, '#ff9516');
		//percentages
		percentOne = percent(scoreOne,total);
		writeArcText(percentOne + '%', theta-14, 113);
		writeArcText((100-percentOne) + '%', theta+14, 113);
		//time remaining
		var style = {'font-family': 'Helvetica', 'font-size': 11, 'fill': '#b0b0b0'};
		writeText(140, 105, 'FALTAM', style);
		writeText(140, 155, 'PARA ENCERRAR A VOTAÇÃO', style);
		style = {'font-family': 'Helvetica', 'font-size': 32, 'fill': '#ff9516'};
		writeText(140, 130, hours + ':' + minutes + ':' + seconds, style);
	}

	var drawArc = function(theta, radius, thickness, color) {
		
		var arc = canvas.arc(140, 140, theta, radius);
		arc.attr({'stroke': color, 'stroke-width': thickness});
	}

	var drawCircle = function(radius, color) {

		var circle = canvas.circle(140, 140, radius);
		circle.attr({'fill': color, 'stroke-width': 0});
	}

	var writeArcText = function(text, theta, radius) {

		var coords = Geometry.coords(140, 140, theta, radius);
		var txt = canvas.text(coords.x, coords.y, text);
		txt.attr({'font-family': 'Arial', 'font-size': 18, 'fill': '#fff'});
		txt.transform('r' + (theta+178));
	}

	var writeText = function(x, y, text, style) {

		var txt = canvas.text(x, y, text);
		txt.attr(style);
	}

	var arcAngle = function(partial, total) {

		return total == 0 ? 0: 360 / total * partial;;
	}

	var percent = function(partial, total) {

		return total == 0 ? 0 : Math.floor(partial * 100 / total);
	}

	return {

		init:init,
		renderDonutChart:renderDonutChart
	};
})();

var Voting = (function() {

	var selectParticipant = function(element) {

		$('.participant-box').each(function() {
			$(this).removeClass('selected');
		})
		element.find('div:first').addClass('selected');
		$('#votingForm').attr('action', '/voting/' + element.attr('participant-id'));
	}

	var captcha = function(e) {

		if(!$('#votingForm').attr('action')) {
			alert('Selecione um participante!');
			return;
		}
		e.preventDefault();
	  	$('#captchaModal').reveal();
	}

	var vote = function() {
		
		$('#votingForm').submit();
	}

	return {

		selectParticipant:selectParticipant,
		captcha:captcha,
		vote:vote
	};
})();

$(function() {

	$('.participant-option').click(function(){
		Voting.selectParticipant($(this));
		return false;
	});

	$('#voteBtn').click(function(e){
		Voting.captcha(e);
		return false;
	});

	$('#captchaBtn').click(function(e){
		Voting.vote();
		return false;
	});	

	if($('#chartBox').length > 0) {
		Graphics.init('chartBox');
		Graphics.renderDonutChart(scoreOne,scoreTwo);
	}
});