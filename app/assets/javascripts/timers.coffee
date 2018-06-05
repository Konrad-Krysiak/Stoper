$(document).ready ->
# --VARIABLES AND FUNCTIONS--
	callback = 0 # Used to updata db data when timer is switched to OFF
	x = undefined # Declared globaly to gain clearInterval ability in other functions
	state_bol = getState() # Get current state from Views > Freshly loaded from controller

# --IF STOPER STATE IS TRUE RUN STOPPER AUTOMATICALLY AFTER VIEW IS LOADED--

	OnRender = ->
		$.ajax({
			url: '/timer/on_render'
			dataType: "json"
			success: (data)->
				if state_bol==true
					timeInterval data['time_difference']
				return
		})

# ----------------------------------------------------------------------

# --FUNCTIONS--
	timeInterval = (time)->
		x = setInterval((->
			if time >= 0
				$("#time").html "Time: " + time
				console.log time
				time -= 1
				callback = time
		), 1000, time)

	UpToDate =->
		y = setInterval((->
			$.ajax({
				url: '/timer/UpToDate'
				dataType: 'json'
				method: 'POST'
				data: {state: state_bol}
				success: (data)->
					if data['changes_occurred']
						if state_bol
							switch_off data
						else
							switch_on data
						return
					return
			})
			), 500)

	switch_on = (data)->
		$("#state").html "State: " + data['state']
		timeInterval data['time']
		state_bol = true

	switch_off = (data)->
		$("#state").html "State: " + data['state']
		clearInterval x
		state_bol = false

#  -----------------------------

# --EVENT LISTENERS--

	$("#switch_on").click ->
		$.ajax({
			url: '/timer/switch_on'
			dataType: "json"
			success: (data)->
				switch_on data
	})
	$("#switch_off").click ->
		$.ajax({
			url: '/timer/switch_off'
			method: 'POST'
			data: { callback_time: callback }
			dataType: "json"
			success: (data)->
				switch_off data
		})

# ----------------------------------------------------------------------

	OnRender()
	UpToDate()