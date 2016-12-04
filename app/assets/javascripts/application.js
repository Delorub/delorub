// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require jquery.turbolinks
//= require jquery_ujs
// require turbolinks

//= require jquery-ui
//= require jquery.autocomplete

// require jquery-ui
// require autocomplete-rails

// require turbolinks.redirect

//= require jquery.slides.min

//= require fancybox/jquery.fancybox
//= require fancybox/jquery.fancybox.pack
//= require fancybox/jquery.fancybox-buttons
//= require fancybox/jquery.fancybox-media
//= require fancybox/jquery.fancybox-thumbs

//= require jquery.plugin
//= require jquery.realperson
//= require jquery.mask

//= require animations
//= require notify

$(function(){
	$(".task .task-left-list .left-map .map-full, .order-info-4 .form-2 .map-block > a, .task .task-right .map-block .full-map, .profile-right .full-map").click(function(){
		$(".popup-hidden").show();
		$("#map").parent().addClass("full");
		google.maps.event.trigger(map, 'resize');
		return false;
	});

	$(".works a").fancybox();

	$(".sertif a").fancybox();
	$(".task .task-right .description .info-img").fancybox();

	$('#autocomplete').autocomplete({
	    serviceUrl: "/city-serach",
	      minLength: 2,
	      onSelect: function( event, ui ) {
	      	var id = event.id;
	      	document.location.href="/cat/"+id;
	      }
	});
});

$(window).resize(function(){
	var h_header = parseInt($("header").css("height"));
	if ($(window).height() > (621 + 70)) {
		$(".main-form").css({"height": $(window).height() - 70 + "px"});
		$(".main-form .left").css({"height": $(window).height() - 70 + "px"});
	}
});

$(window).scroll(function(){
	var scroll = $(window).scrollTop();
	if (scroll > 105) {
		$(".header-fixed").addClass("header-fixed-show");
	} else {
		$(".header-fixed").removeClass("header-fixed-show");
	}
});

$(function() {

	var h_header = parseInt($("header").css("height"));
	if ($(window).height() > (621 + 70)) {
		$(".main-form").css({"height": $(window).height() - 70 + "px"});
		$(".main-form .left").css({"height": $(window).height() - 70 + "px"});
	}

	$( ".datepicker" ).datepicker({
		dateFormat: "dd.mm.yy"
	});

	$( "#slider-amount" ).slider({
      value:2000,
      min: 0,
      max: 10000,
      step: 2000,
      range: "min",
      slide: function( event, ui ) {
      	$(".fomt-2-1").removeClass("fomt-active");
		$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
		$(".fomt-2-2").removeClass("fomt-active");
		$(".fomt-2-2 input[type='checkbox']").prop('checked', false);
		$(".fomt-2-3").addClass("fomt-active");
		$(".fomt-2-3 input[type='checkbox']").prop('checked', true); 

        if (ui.value == 0) {
        	$(".order-info-2 .fomt-2-3 .my-slider .label").text("Укажите бюджет");
        	$(".order-info-2 .fomt-2-3 .my-slider .value").html("ДО - 0 <img src='/assets/r-2.png'>");
        }
        if (ui.value == 2000) {
        	$(".order-info-2 .fomt-2-3 .my-slider .label").text("МЕЛКИЙ");
        	$(".order-info-2 .fomt-2-3 .my-slider .value").html("ДО - 2000 <img src='/assets/r-2.png'>");
        }
        if (ui.value == 4000) {
        	$(".order-info-2 .fomt-2-3 .my-slider .label").text("НЕБОЛЬШОЙ");
        	$(".order-info-2 .fomt-2-3 .my-slider .value").html("ДО - 4000 <img src='/assets/r-2.png'>");
        }
        if (ui.value == 6000) {
        	$(".order-info-2 .fomt-2-3 .my-slider .label").text("СРЕДНИЙ");
        	$(".order-info-2 .fomt-2-3 .my-slider .value").html("ДО - 6000 <img src='/assets/r-2.png'>");
        }
        if (ui.value == 8000) {
        	$(".order-info-2 .fomt-2-3 .my-slider .label").text("БОЛЬШОЙ");
        	$(".order-info-2 .fomt-2-3 .my-slider .value").hmtl("ДО - 8000 <img src='/assets/r-2.png'>");
        }
        if (ui.value == 10000) {
        	$(".order-info-2 .fomt-2-3 .my-slider .label").text("МАКСИМАЛЬНЫЙ");
        	$(".order-info-2 .fomt-2-3 .my-slider .value").html("ДО - 10000 <img src='/assets/r-2.png'>");
        }
        $('input[name="price_range"]').val(ui.value);

      }
    });
	
	$(".popup-reg input[name='user[phone1]']").mask('+7 (000)-000-00-00');

	$(".popup-enter, .top-status .btns .btn, footer .btn-master").click(function(){
		$(".popup-hidden").show();
		$(".popup-auth").show();
		return false;
	})
	
	$(".popup-hidden, .popup .close").click(function(){
		$(".popup-hidden").hide();
		$(".popup").hide();
		$("#map").parent().removeClass("full");
		$(".popup-settings").show();
		return false;
	});

	$(".order-info-4 .form-1 .right .btn").click(function(){
		$(".popup-hidden").show();
		$(".popup-soc").show();
		return false;
	});

	$(".fomt-2-1 input[type='checkbox']").change(function(){
		if ($(this).is(':checked')) {
			$(".fomt-2-1").removeClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-2").removeClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-3").removeClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
			$(this).parent().addClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', true); 
		} else {
			$(".fomt-2-1").removeClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-2").removeClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', false);
			$(".fomt-2-3").removeClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
		}
	});

	$(".fomt-2-2 input[type='checkbox']").change(function(){
		if ($(this).is(':checked')) {
			$(".fomt-2-1").removeClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-2").removeClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-3").removeClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
			$(this).parent().addClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', true); 
		} else {
			$(".fomt-2-1").removeClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-2").removeClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', false);
			$(".fomt-2-3").removeClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
		}
	});

	$(".fomt-2-3 input[type='checkbox']").change(function(){
		if ($(this).is(':checked')) {
			$(".fomt-2-1").removeClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-2").removeClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-3").removeClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
			$(this).parent().addClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', true); 
		} else {
			$(".fomt-2-1").removeClass("fomt-active");
			$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
			$(".fomt-2-2").removeClass("fomt-active");
			$(".fomt-2-2 input[type='checkbox']").prop('checked', false);
			$(".fomt-2-3").removeClass("fomt-active");
			$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
		}
	});

	$('.order-info-2 .fomt-2-1 input[type="text"]').click(function(){
		$(".fomt-2-1").addClass("fomt-active");
		$(".fomt-2-1 input[type='checkbox']").prop('checked', true); 
		$(".fomt-2-2").removeClass("fomt-active");
		$(".fomt-2-2 input[type='checkbox']").prop('checked', false);
		$(".fomt-2-3").removeClass("fomt-active");
		$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
		return false;
	});

	$('.order-info-2 .fomt-2-2 input[type="text"]').click(function(){
		$(".fomt-2-1").removeClass("fomt-active");
		$(".fomt-2-1 input[type='checkbox']").prop('checked', false); 
		$(".fomt-2-2").addClass("fomt-active");
		$(".fomt-2-2 input[type='checkbox']").prop('checked', true);
		$(".fomt-2-3").removeClass("fomt-active");
		$(".fomt-2-3 input[type='checkbox']").prop('checked', false); 
		return false;
	});

	$(".order-info-3 .form-1 input[type='checkbox']").change(function(){
		if ($(this).is(':checked')) {
			$(".order-info-3 .form-1").removeClass("form-active");
			$(".order-info-3 .form-1 input[type='checkbox']").prop('checked', false); 
			$(".order-info-3 .form-2").removeClass("form-active");
			$(".order-info-3 .form-2 input[type='checkbox']").prop('checked', false); 
			$(this).parent().addClass("form-active");
			$(".order-info-3 .form-1 input[type='checkbox']").prop('checked', true); 
		} else {
			$(".order-info-3 .form-1").removeClass("form-active");
			$(".order-info-3 .form-1 input[type='checkbox']").prop('checked', false);
			$(".order-info-3 .form-2").removeClass("form-active");
			$(".order-info-3 .form-2 input[type='checkbox']").prop('checked', false); 
		}
	});

	$(".order-info-3 .form-2 input[type='checkbox']").change(function(){
		if ($(this).is(':checked')) {
			$(".order-info-3 .form-1").removeClass("form-active");
			$(".order-info-3 .form-1 input[type='checkbox']").prop('checked', false); 
			$(".order-info-3 .form-2").removeClass("form-active");
			$(".order-info-3 .form-2 input[type='checkbox']").prop('checked', false); 
			$(this).parent().addClass("form-active");
			$(".order-info-3 .form-2 input[type='checkbox']").prop('checked', true); 
		} else {
			$(".order-info-3 .form-1").removeClass("form-active");
			$(".order-info-3 .form-1 input[type='checkbox']").prop('checked', false);
			$(".order-info-3 .form-2").removeClass("form-active");
			$(".order-info-3 .form-2 input[type='checkbox']").prop('checked', false); 
		}
	});

	$('select[name="cat"]').change(function(){
		var cat = $(this).val();
		$(".sub-cat").hide();
		$(".sub-cat[parent_id='"+cat+"']").show();
	});

	$("input[type='submit'].btn-red").click(function(){
		var cat = $('select[name="cat"]').val();
		if (cat == 0 || cat == "0") {
			alert("Укажите категорию");
			return false;
		}

		var cat_sub = $('select[name="cat_sub"]').val();
		if (cat_sub == 0 || cat_sub == "0") {
			alert("Укажите подкатегорию");
			return false;
		}

		var name = $('input[name="name"]').val();
		if (name.length == 0) {
			alert("Укажите заголовок");
			return false;
		}

		var description = $('textarea[name="description"]').val();
		if (description.length == 0) {
			alert("Укажите описание");
			return false;
		}

		if($(".fomt-2-1 input[type='checkbox']").is(":checked")) {
			var price_fix = $('input[name="price_fix"]').val();
			if (price_fix.length == 0) {
				alert("Укажите фиксированный бюджет");
				return false;
			}
		}

		if($(".fomt-2-2 input[type='checkbox']").is(":checked")) {
			var price_1 = $('input[name="price_1"]').val();
			if (price_1.length == 0) {
				alert("Укажите бюджет от");
				return false;
			}
			var price_2 = $('input[name="price_2"]').val();
			if (price_2.length == 0) {
				alert("Укажите бюджет до");
				return false;
			}
		}

		if($(".fomt-2-3 input[type='checkbox']").is(":checked")) {
			var price_fixed = $('input[name="price_fixed"]').val();
			if (price_fixed.length == 0) {
				alert("Укажите бюджет по шкале");
				return false;
			}
		}

		if($("input[type='checkbox'][name='time_type_1']").is(":checked")) {
			var date_aktual = $('input[name="date_aktual"]').val();
			var date_count = $('input[name="date_count"]').val();
			if (date_count.length == 0) {
				if (date_aktual.length == 0) {
					alert("Укажите дату актуальности");
					return false;
				}
			}
			if (date_aktual.length == 0) {
				if (date_count.length == 0) {
					alert("Укажите количество дней актуальности");
					return false;
				}
			}
		}

		if($("input[type='checkbox'][name='time_type_2']").is(":checked")) {
			var date_start = $('input[name="date_start"]').val();
			if (date_start.length == 0) {
				alert("Укажите дату начала");
				return false;
			}
			var date_stop = $('input[name="date_stop"]').val();
			if (date_stop.length == 0) {
				alert("Укажите дату конца");
				return false;
			}
		}

		if ($('input[name="name1"]').length > 0) {
			var name1 = $('input[name="name1"]').val();
			if (name1.length == 0) {
				alert("Укажите Имя");
				return false;
			}
			var name2 = $('input[name="name2"]').val();
			if (name2.length == 0) {
				alert("Укажите Фамилию");
				return false;
			}
			var phone = $('input[name="phone"]').val();
			if (phone.length == 0) {
				alert("Укажите Номер телефона");
				return false;
			}
			var email = $('input[name="email"]').val();
			if (email.length == 0) {
				alert("Укажите e-mail");
				return false;
			}
			var password = $('input[name="password"]').val();
			if (password.length == 0) {
				alert("Укажите пароль");
				return false;
			}
			var password2 = $('input[name="password2"]').val();
			if (password2.length == 0) {
				alert("Укажите повтор пароля");
				return false;
			}

			if (password != password2) {
				alert("пароли не совпадают");
				return false;	
			}
		}

		var city_from = $('input[name="city_from"]').val();
		if (city_from.length == 0) {
			alert("Укажите Город пункта отправления");
			return false;
		}
		var address_from = $('input[name="address_from"]').val();
		if (address_from.length == 0) {
			alert("Укажите Улицу пункта отправления");
			return false;
		}
		var house_from = $('input[name="house_from"]').val();
		if (house_from.length == 0) {
			alert("Укажите Дом пункта отправления");
			return false;
		}
		var kv_from = $('input[name="kv_from"]').val();
		if (kv_from.length == 0) {
			alert("Укажите Квартиру пункта отправления");
			return false;
		}

		if($("input[type='checkbox'][name='soglashenie']").length > 0) {
			if(!$("input[type='checkbox'][name='soglashenie']").is(":checked")) {
				alert("Пожалуйста примите соглашение");
				return false;
			}
		}

		$(".popup-alert .title").text("Спасибо");
		$(".popup-alert .quest-text").text("Ваша заявка размещена. Она появится на сайте после проверки модераторами. Вы можете отредактировать или воспользоваться платными услугами в личном кабинете.");
		$(".popup-alert").show();
		$(".popup-hidden").show();
		setTimeout(function () {$('form[action="/create-task"]').submit()},6000);

	});

	$(".edit-contacts").click(function(){
		$(".popup-hidden").show();
		$(".popup-contacts").show();
		return false;
	});

	$(".edit-learn").click(function(){
		$(".popup-hidden").show();
		$(".popup-learn").show();
		return false;
	});

	$(".edit-garant").click(function(){
		$(".popup-hidden").show();
		$(".popup-garant").show();
		return false;
	});

	$(".edit-pays").click(function(){
		$(".popup-hidden").show();
		$(".popup-pays").show();
		return false;
	});

	$(".edit-raions").click(function(){
		$(".popup-hidden").show();
		$(".popup-raions").show();
		return false;
	});

	$(".edit-other").click(function(){
		$(".popup-hidden").show();
		$(".popup-other").show();
		return false;
	});

	$(".edit-spec").click(function(){
		$(".popup-hidden").show();
		$(".popup-spec").show();
		return false;
	});

	$(".edit-image").click(function(){
		$(".popup-hidden").show();
		$(".popup-image").show();
		return false;
	});

	$(".profile-right .btn-green").click(function(){
		$(".popup-hidden").show();
		$(".popup-message").show();
		return false;
	});

	$(".fake").click(function(){
		$(".popup-hidden").show();
		$(".popup-fake").show();
		return false;
	});

	$(".profile-left .user .likes img").click(function(){
		var user_id = $(this).attr("user_id");
		$.post("/like", {user_id: user_id}, function(date){
			if (date.error == true) {
				alert(date.error_text);
			} else {
				document.location.href = document.location.href;
			}
		});
		return false;
	});

	$("input[name='file_image']").change(function(){
		var obj = this;
		var id = $(this).attr("id");
		id = parseInt(id.substring(3, id.length));
		if (obj.files.length == 1) {
			if (obj.files && obj.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $('.order-info-1 .fomt-1 label .img-bg').attr({"src": e.target.result});

		        }
		        reader.readAsDataURL(obj.files[0]);
		    }
		}
	});

	$("input[id='photo']").change(function(){
		var obj = this;
		var id = $(this).attr("id");
		id = parseInt(id.substring(3, id.length));
		if (obj.files.length == 1) {
			if (obj.files && obj.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $('.reg-form .reg-from-1 label .img-bg').attr({"src": e.target.result});
		            $('.reg-form .reg-from-1 label .img-bg').show();

		        }
		        reader.readAsDataURL(obj.files[0]);
		    }
		}
	});

	$("#user_password").change(function(){
		var value = $(this).val();
		$("#user_password_repeat").val(value);
		return false;
	});

	$(".main-form .mouse-block img, .top-registration .scroll img").click(function(){
		$('html, body').animate({
	    	scrollTop: $(window).height()
		}, 500, function(){
		});  
		return false;
	});

	$(".right-block-settings .btn").click(function(){
		$(".popup-shablon").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".right-block-balance .btn").click(function(){
		$(".popup-balance").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".right-block-settings .line a").click(function(){
		var answer_id = $(this).attr("answer_id");
		var name = $(this).attr("name");
		var description = $(this).attr("description");
		$(".popup-shablon input[name='answer_id']").val(answer_id);
		$(".popup-shablon input[name='name']").val(name);
		$(".popup-shablon textarea").val(description);
		$(".popup-shablon").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".right-block-settings .answer_remove").click(function(){
		var answer_id = $(this).attr("answer_id");
		$.post("/answer_remove", {answer_id: answer_id}, function(){
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".btn-master-task").click(function(){
		$(".popup-order").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".btn-master-task-delete").click(function(){
		var order_id = $(this).attr("order_id");
		var task_id = $(this).attr("task_id");
		$.post("/delete_order", {order_id: order_id, task_id: task_id}, function(){
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".comment-item .comemnt-text .btns .btn-answer").click(function(){
		var from_user = $(this).attr("from_user");
		var to_user = $(this).attr("to_user");
		var order_id = $(this).attr("order_id");
		$(".popup-answer input[name='from_user']").val(from_user);
		$(".popup-answer input[name='to_user']").val(to_user);
		$(".popup-answer input[name='order_id']").val(order_id);
		$(".popup-answer").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".btn-master-task-edit").click(function(){
		var order_id = $(this).attr("order_id");
		var price = $(this).attr("price");
		var ltime = $(this).attr("ltime");
		var description = $(this).attr("description");
		$(".popup-order input[name='order_id']").val(order_id);
		$(".popup-order input[name='price']").val(price);
		$(".popup-order input[name='ltime']").val(ltime);
		$(".popup-order textarea").val(description);
		$(".popup-order").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".btn-order-yes").click(function(){
		var order_id = $(this).attr("order_id");
		var userdo_id = $(this).attr("userdo_id");
		var task_id = $(this).attr("task_id");
		$.post("/change_order", {order_id: order_id, userdo_id: userdo_id, status: "yes", task_id: task_id}, function(data){
			$(".popup-hidden").show()
			$(".popup-answer-yes span.name").text(data.name);
			$(".popup-answer-yes").show()
		});
		return false;
	});

	$(".btn-order-no").click(function(){
		var order_id = $(this).attr("order_id");
		var userdo_id = $(this).attr("userdo_id");
		var task_id = $(this).attr("task_id");
		$.post("/change_order", {order_id: order_id, userdo_id: userdo_id, status: "no", task_id: task_id}, function(){
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".btn-task-done").click(function(){
		var task_id = $(this).attr("task_id");
		var status = $(this).attr("status");
		$.post("/change_task", {task_id: task_id, status: status}, function(){
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".btn-task-finish").click(function(){
		var task_id = $(this).attr("task_id");
		var status = $(this).attr("status");
		$.post("/change_task", {task_id: task_id, status: status}, function(){
			$(".popup-recall").show();
			$(".popup-hidden").show();
		});
		return false;
	});

	$(".task .task-left ul li a, .questions a, .question-list ul li a, .question-ul a").click(function(){
		$(".popup-quest").show();
		$(".popup-hidden").show();
		return false;
	});

	$(".task-list .sort select").change(function(){
		$(this).parent().submit();
	});

	$(".btn-set-user-type").click(function(){
		var user_type = $(this).attr("user_type");
		$.post("/set_user_type", {user_type:user_type}, function(){
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".profile-task .delete").click(function(){
		var task_id = $(this).attr("task_id");
		$.post("/task_delete", {task_id: task_id}, function(){
			alert("Ваша заявка удалена.");
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".profile-task .archive").click(function(){
		var task_id = $(this).attr("task_id");
		$.post("/task_archive", {task_id: task_id}, function(){
			alert("Ваша заявка перемещена в архив.");
			document.location.href = document.location.href;
		});
		return false;
	});

	$(".btn-answer").click(function(){
		var to_user_id = $(this).attr("to_user_id");
		$(".popup-message input[name='user_id']").val(to_user_id);
		$(".popup-hidden").show();
		$(".popup-message").show();
		return false;
	});

	$(".popup-recall form").submit(function(){
		if ($(".popup-recall textarea").val().length == 0) {
			alert("Напишите текст отзыва");
			return false;
		}
	});

	$(".popup-recall input[type='checkbox']").change(function(){
		var rating = 10;
		console.log(1);
		$(".popup-recall input[type='checkbox']").each(function(){
			if (!$(this).prop('checked')) {
				rating -= 1;
			}
		});
		$(".popup-recall .rating span").text(rating);
	});

	$(".go-to-reg").click(function(){
		$(".popup-auth").hide();
		$(".popup-reg").show();
		return false;
	});

	$(".go-to-auth").click(function(){
		$(".popup-auth").show();
		$(".popup-reg").hide();
		return false;
	});

	$(".go-to-rember").click(function(){
		$(".popup").hide();
		$(".popup-rememb").show();
		return false;
	});

	$(".new_user_reg").submit(function(){
		var ismaster = $(".new_user_reg input[name='ismaster']").val();
		var email = $(".new_user_reg input[name='email']").val();
		var phone = $(".new_user_reg input[name='phone']").val();
		var code = $(".new_user_reg input[name='code']").val();
		if (email.length == 0) {
			alert("Укажите email");
			return false;
		}
		if (phone.length == 0) {
			alert("Укажите телефон");
			return false;
		}
		$.post("/new_user_reg", {ismaster: ismaster, email: email, phone: phone}, function(data){
			if (data.error == true || data.error == "true") {
				alert(data.error_text);
				return false;
			} else {
				alert("Ваш пароль: " + data.password);
				document.location.href = document.location.href;
			}
		});
		return false;
	});

	$(".new_user").submit(function(){
		var email = $(".new_user input[name='user[email]']").val();
		var password = $(".new_user input[name='user[password]']").val();
		if (email.length == 0) {
			alert("Укажите email");
			return false;
		}
		if (password.length == 0) {
			alert("Укажите пароль");
			return false;
		}
		$.post("/new_user", {email: email, password: password}, function(data){
			if (data.error == true || data.error == "true") {
				alert(data.error_text);
				return false;
			} else {
				document.location.href = document.location.href;
			}
		});
		return false;
	});

	$(".new_user_rememb").submit(function(){
		var email = $(".new_user_rememb input[name='email']").val();
		if (email.length == 0) {
			alert("Укажите email");
			return false;
		}
		/*
		$.post("/new_user", {email: email, password: password}, function(data){
			if (data.error == true || data.error == "true") {
				alert(data.error_text);
				return false;
			} else {
				document.location.href = document.location.href;
			}
		});*/
		alert("Пароль выслан вам на почту.");
		$(".popup").hide();
		$(".popup-hidden").hide();
		return false;
	});

	$('form[action="/profile/step2_1"]').on('keyup keypress', function(e) {
	  var keyCode = e.keyCode || e.which;
	  if (keyCode === 13) { 
	    e.preventDefault();
	    return false;
	  }
	});

	$(".reg-form .reg-from-2-2 .add-price").click(function(){
		var el = $(".reg-from-2-2 .price-list .item:first").clone();
		$("input", el).val("");
		$(".reg-form .reg-from-2-2 .price-list").append(el);
		return false;
	});

	$(".reg-form .reg-from-2-2 .raion-btn").click(function(){
		var el = $(".reg-from-2-2 .raion-list .item:first").clone();
		$("input", el).val("");
		$(".reg-form .reg-from-2-2 .raion-list").append(el);
		return false;
	});

	$(".tops .question").click(function(){
		$(".popup-hidden").show();
		$(".popup-top-master").show();
		return false;
	});

	$(".btn-recall-answer").click(function(){
		var from_user_id = $(this).attr("from_user_id");
		var user_id = $(this).attr("user_id");
		var task_id = $(this).attr("task_id");
		var parent_id = $(this).attr("parent_id");
		$(".popup-recall-answer input[name='from_user_id']").val(from_user_id);
		$(".popup-recall-answer input[name='user_id']").val(user_id);
		$(".popup-recall-answer input[name='task_id']").val(task_id);
		$(".popup-recall-answer input[name='parent_id']").val(parent_id);
		$(".popup-hidden").show();
		$(".popup-recall-answer").show();
		return false;
	});

	$(".delete-message").click(function(){
		var message_id = $(this).attr("message_id");
		$.post("/message_delete", {message_id: message_id}, function(){
			document.location.href = document.location.href;
		});
		return false;
	});

})


