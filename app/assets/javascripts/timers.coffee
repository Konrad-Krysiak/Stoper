$(document).ready ->
#  ---VARIABLES AND FUNCTIONS----
	callback = 0
#				date_difference = data['time'] - Math.ceil((Date.now()-data['updated_at'])/1000) 
	x = undefined

	timeInterval = (time)->
		x = setInterval((->
			if time >= 0
				$("#time").html "Time: " + time
				console.log time
				time -= 1
				callback = time
			return
		), 1000, time)

#  -----------------------------

# IF STOPER STATE IS TRUE RUN STOPPER AUTOMATICALLY AFTER VIEW IS LOADED
	$.ajax({
		url: '/timer/on_render'
		dataType: "json"
		success: (data)->
			if data['state']==true
				timeInterval data['time_difference']
			return
	})
# ----------------------------------------------------------------------



	$("#switch_on").click ->
		$.ajax({
			url: '/timer/switch_on'
			dataType: "json"
			success: (data)->
				$("#state").html "State: " + data['state']
				timeInterval data['time']
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