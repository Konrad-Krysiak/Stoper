$(document).ready ->
#  ---VARIABLES----
	callback = 0
	x = undefined
#  ----------------

# IF STOPER STATE IS TRUE RUN STOPPER AUTOMATICALLY AFTER VIEW IS LOADED
	$.ajax({
		url: '/timer/on_render'
		dataType: "json"
		success: (data)->
			if data['state']==true
				date_difference = Math.abs(Date.now() - (data['updated_at'])) / 36e5
				alert(date_difference)
			return
	})


	$("#switch_on").click ->
		$.ajax({
			url: '/timer/switch_on'
			dataType: "json"
			success: (data)->
				$("#state").html "State: " + data['state']
				time = data['time']
				x = setInterval((->
				  if time >= 0
				    $("#time").html "Time: " + time
				    time -= 1
				    callback = time
				  return
				), 1000, time)
		})
	$("#switch_off").click ->
		$.ajax({
			url: '/timer/switch_off'
			method: 'POST'
			data: { callback_time: callback }
			dataType: "json"
			success: (data)->
				$("#state").html "State: " + data['state']
				clearInterval x
		})
	$("#increase_time").click ->
		$.ajax({
			url: '/timer/switch_on'
			dataType: "json"
			success: (data)->
				alert "twoja matka"
		})
	$("#decrease_time").click ->
		$.ajax({
			url: '/timer/switch_on'
			dataType: "json"
			success: (data)->
				alert "twoja matka"
		})