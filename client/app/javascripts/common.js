import './home/home.js'

$(document).ready(function() {

$('.star span').each(function (N){
		$(this).hover(function (){
			var act = $('.star span.act').length;
			var obj = N;
			if(act>obj)	$('.star span').removeClass('act');
			for($a=0; $a<=obj; $a++) $('.star span:eq('+$a+')').addClass('act');
			$('input[name=rating]').val(obj+1);
		});
	});
	$('.star').click( function(){
		$( this ).addClass('stop');
	});

	$('.star1').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star1 span').removeClass('act');
	})
	$('.star1 span').each(function (N){
		$(this).hover(function (){
			var act = $('.star1 span.act').length;
			var obj = N;
			if(act>obj)	$('.star1 span').removeClass('act');
			for($a=0; $a<=obj; $a++) $('.star1 span:eq('+$a+')').addClass('act');
			$('input[name=rating1]').val(obj+1);
		});
	});
	$('.star1').click( function(){
		$( this ).addClass('stop');
	});

	$('.star1').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star1 span').removeClass('act');
	})


$('.star2').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star2 span').removeClass('act');
	})
	$('.star2 span').each(function (N){
		$(this).hover(function (){
			var act = $('.star2 span.act').length;
			var obj = N;
			if(act>obj)	$('.star2 span').removeClass('act');
			for($a=0; $a<=obj; $a++) $('.star2 span:eq('+$a+')').addClass('act');
			$('input[name=rating2]').val(obj+1);
		});
	});
	$('.star2').click( function(){
		$( this ).addClass('stop');
	});

	$('.star3').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star3 span').removeClass('act');
	})
$('.star3').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star3 span').removeClass('act');
	})
	$('.star3 span').each(function (N){
		$(this).hover(function (){
			var act = $('.star3 span.act').length;
			var obj = N;
			if(act>obj)	$('.star3 span').removeClass('act');
			for($a=0; $a<=obj; $a++) $('.star3 span:eq('+$a+')').addClass('act');
			$('input[name=rating3]').val(obj+1);
		});
	});
	$('.star3').click( function(){
		$( this ).addClass('stop');
	});

	$('.star3').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star3 span').removeClass('act');
	})

$('.star4').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star4 span').removeClass('act');
	})
	$('.star4 span').each(function (N){
		$(this).hover(function (){
			var act = $('.star4 span.act').length;
			var obj = N;
			if(act>obj)	$('.star4 span').removeClass('act');
			for($a=0; $a<=obj; $a++) $('.star4 span:eq('+$a+')').addClass('act');
			$('input[name=rating4]').val(obj+1);
		});
	});
	$('.star4').click( function(){
		$( this ).addClass('stop');
	});

	$('.star4').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star4 span').removeClass('act');
	})
$('.star5').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star5 span').removeClass('act');
	})
	$('.star5 span').each(function (N){
		$(this).hover(function (){
			var act = $('.star5 span.act').length;
			var obj = N;
			if(act>obj)	$('.star5 span').removeClass('act');
			for($a=0; $a<=obj; $a++) $('.star5 span:eq('+$a+')').addClass('act');
			$('input[name=rating5]').val(obj+1);
		});
	});
	$('.star5').click( function(){
		$( this ).addClass('stop');
	});

	$('.star5').mouseout( function(){
		if( $(this).hasClass('stop') ) return false;
		$('.star5 span').removeClass('act');
	})
});
