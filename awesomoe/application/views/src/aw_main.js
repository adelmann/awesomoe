$(document).ready(function() {
	
	// Check Sidebar is out or in
	var sidebarCookie = getCookie('awesomeo-sidebar');
    if (sidebarCookie != null && sidebarCookie != "") {
		if (sidebarCookie == 'true') {
			$('body').addClass('sidebar-collapse');
		} 
    }
	
	$('a.fnc').click(function() {return false;});
	
	$('body').on('click', '.timepicker', function() {
		$(this).timepicker({
			showInputs: false,
			showMeridian: false,
			defaultTime: '00:00'
		}).focus();
	});
	
	
	$('.sidebar-toggle').click(function() {
		if ($('body.sidebar-collapse').length > 0) {
			document.cookie="awesomeo-sidebar=true";
		} else {
			document.cookie="awesomeo-sidebar=false";
		}
	});

	// Workflows
	
	// New Step
	$('#addWorkflowStep').click(function() {
		lastStep = $('#workflowsteps tr:last td:first input').attr('name');
		workflowid = $(this).closest('form').children('input[name=awid]').val();
		if (lastStep) {
			workflowStepId = lastStep.replace(/awname-(.*?)-sort(.+?)/g, "$2");
			newStepId = parseInt(workflowStepId)+1;
		} else {
			newStepId = 1;
		}
		$('#workflowsteps tr:last td:last span:first').after("<span class='btn btn-default btn-flat'><i class='fa fa-arrow-down'></i></span>");
		$('#workflowsteps').append("<tr class='datas'><td><input type='text' id='name' class='form-control' name='awname-0-sort"+newStepId+"' value=''></td><td><div class='btn-group'><span class='btn btn-default btn-flat'><i class='fa fa-arrow-up'></i></span><span class='btn btn-default btn-flat'><i class='fa fa-minus'></i></span></div></td></tr>");
		reSortWorkflows();
	});
	
	// Change Sort
	$('body').on('click', 'span.sortup', function() {
		thistr = $(this).closest('tr.datas').html();
		if ($(this).closest('tr.datas').prev('tr.datas').length > 0) { 	
			$(this).closest('tr.datas').prev().before('<tr class="datas">'+thistr+'</tr>');
			$(this).closest('tr.datas').remove();
			reSortWorkflows()
		}
	});

	$('body').on('click', 'span.sortdown', function() {
		thistr = $(this).closest('tr.datas').html();
		if ($(this).closest('tr.datas').next('tr.datas').length > 0) { 	
			$(this).closest('tr.datas').next().after('<tr class="datas">'+thistr+'</tr>');
			$(this).closest('tr.datas').remove();
			reSortWorkflows();
		}
	});
	
	$('body').on('click', 'span.delstep', function() {
		myid = $(this).closest('form').children('input[name=awid]').val();
		mysortid = $(this).closest('tr').children('td').children('input').attr('name');
		workflowStepId = mysortid.replace(/awname-(.*?)-sort(.+?)/g, "$2");
		$('#deleteworkflowitem input[name=delitem]').val(workflowStepId);
		$(this).closest('tr.datas').remove();
		$('#deleteworkflowitem').submit();
	});
	
	// TIMELOG
	$('#logtime').click(function() {
		projectid = $('#projectid').val();
		taskid = $('#taskid').val();
		datas = 'cl=worklog&fnc=getLogForm&project='+projectid+'&task='+taskid;
		$.ajax({
			url:"index.php",
			data: datas,
			success:function(response) {
				$('.modal.timelog').replaceWith(response);
				$(".modal.timelog .texteditor").wysihtml5();
				$('.timelog').fadeIn();
			}
		});
	});

	$('body').on('submit', '#modalworklog', function() {
		checkform = validateForm('#modalworklog');
		if (checkform == true) {
			datas = $('#modalworklog').serialize();
			datas = datas+'&fnc=save';
			$.ajax({
				url:"index.php",
				data: datas,
				success:function(response) {
					$('#modalworklog').trigger("reset");
					$('.modal-header').append(response);
					$('.modalresponse').delay(2000).fadeOut();
					$('.timelog').delay(3000).fadeOut();
					getWorklog();
				}
			});
		}
		return false;
	});
	
	$('body').on('click', '.worklogactions .fnc', function() {
		myfnc = $(this).attr('id');
		projectid = $('#projectid').val();
		taskid = $('#taskid').val();
		if (myfnc.indexOf('edit') != -1) {
			fncId = myfnc.replace('edit-','');
			datas = 'cl=worklog&fnc=getEditLog&awworklogid='+fncId+'&project='+projectid+'&task='+taskid;
			$.ajax({
				url:"index.php",
				data: datas,
				success:function(response) {
					$('.modal.timelog').replaceWith(response);
					$(".modal.timelog .texteditor").wysihtml5();
					$('.timelog').fadeIn();
				}
			});
		} else if(myfnc.indexOf('delete') != -1) {
			fncId = myfnc.replace('delete-','');
			$( "#submitdelete" ).bind( "click", function() {
				$('.delete').fadeOut();
			  
				datas = 'cl=worklog&fnc=deleteWorklog&awworklogid='+fncId+'&project='+projectid+'&task='+taskid;
				$.ajax({
					url:"index.php",
					data: datas,
					success:function(response) {
						getWorklog();
					}
				});
			  $( "#submitdelete" ).unbind();
			});
			$( ".cancel" ).click(function() {
				$('.delete').fadeOut();
				$( "#submitdelete" ).unbind();
			});
			$('.delete').fadeIn();
		}
	});
	
	// Comments
	$('#addcomment').click(function() {
		myfnc = $(this).attr('id');
		projectid = $('#projectid').val();
		taskid = $('#taskid').val();
		datas = 'cl=comments&fnc=getCommentForm&project='+projectid+'&task='+taskid;
		$.ajax({
			url:"index.php",
			data: datas,
			success:function(response) {
				$('.modal.comment').replaceWith(response);
				$(".modal.comment .texteditor").wysihtml5();
				$('.comment').fadeIn();
			}
		});
		
		
	});
	$('body').on('submit', '#modalcomments', function() {
		checkform = validateForm('#modalcomments');
		if (checkform == true) {
			datas = $('#modalcomments').serialize();
			datas = datas+'&fnc=save';
			$.ajax({
				url:"index.php",
				data: datas,
				success:function(response) {
					$('#modalcomments').trigger("reset");
					$('.modal-header').append(response);
					$('.modalresponse').delay(2000).fadeOut();
					$('.comment').delay(3000).fadeOut();
					getComments();
				}
			});
		}
		return false;
	});
	
	$('body').on('click', '.commentactions .fnc', function() {
		myfnc = $(this).attr('id');
		projectid = $('#projectid').val();
		taskid = $('#taskid').val();
		if (myfnc.indexOf('edit') != -1) {
			fncId = myfnc.replace('edit-','');
			datas = 'cl=comments&fnc=getEditComments&awcommentid='+fncId+'&project='+projectid+'&task='+taskid;
			$.ajax({
				url:"index.php",
				data: datas,
				success:function(response) {
					$('.modal.comment').replaceWith(response);
					$(".modal.comment .texteditor").wysihtml5();
					$('.comment').fadeIn();
				}
			});
		} else if(myfnc.indexOf('delete') != -1) {
			fncId = myfnc.replace('delete-','');
			$( "#submitdelete" ).bind( "click", function() {
				$('.delete').fadeOut();
			  
				datas = 'cl=comments&fnc=deleteComment&awcommentid='+fncId+'&project='+projectid+'&task='+taskid;
				$.ajax({
					url:"index.php",
					data: datas,
					success:function(response) {
						getComments();
					}
				});
			  $( "#submitdelete" ).unbind();
			});
			$( ".cancel" ).click(function() {
				$('.delete').fadeOut();
				$( "#submitdelete" ).unbind();
			});
			$('.delete').fadeIn();
		}
	});
	
	// Task History

	// Change Task State
	$('#changeState').click(function() {
		$('.StateChange').fadeIn();
	});
	
	$('body').on('submit', '#modalStateChange', function() {
		checkform = validateForm('#modalStateChange');
		if (checkform == true) {
			datas = $('#modalStateChange').serialize();
			datas = datas+'&fnc=changestate';
			$.ajax({
				url:"index.php",
				data: datas,
				success:function(response) {
					$('#modalStateChange').trigger("reset");
					$('.modal-header').append(response);
					$('.modalresponse').delay(2000).fadeOut();
					$('.timelog').delay(3000).fadeOut();
					location.reload();
				}
			});
		}
		return false;
	});
	
	// Assign Task
	$('#assigntask').click(function() {
		$('.assignTask').fadeIn();
	});
	
	$('body').on('submit', '#modalAssign', function() {
		checkform = validateForm('#modalAssign');
		if (checkform == true) {
			datas = $('#modalAssign').serialize();
			datas = datas+'&fnc=changeassignee';
			$.ajax({
				url:"index.php",
				data: datas,
				success:function(response) {
					$('#modalAssign').trigger("reset");
					$('.modal-header').append(response);
					$('.modalresponse').delay(2000).fadeOut();
					$('.timelog').delay(3000).fadeOut();
					location.reload();
				}
			});
		}
		return false;
	});

	// Archive Task
	$('#archiveTask').click(function() {
		projectid = $('#projectid').val();
		taskid = $('#taskid').val();
		data = 'cl=tasklist&fnc=set2archive&project='+projectid+'&task='+taskid;
		$.ajax({
			url:"index.php?"+data,
			success:function(response) {
				location.reload();
			}
		});
	});
		
	// MODAL Handling
	$('body').on('click', 'button.close, button.closebtn', function() {
		$(this).closest('.modal').fadeOut();
	});
	
	// Activity
	
	$('body').on('click','#openWorklog', function() {
		getWorklog();
	});
	
	$('body').on('click','#openComments', function() {
		getComments();
	});
	
	$('body').on('click','#openhistory', function() {
		getHistory();
	});
	
	$("#upload-files").change(function (){
		$('.uploadform .progress-number').html('');
		$('.uploadform .progress-bar').attr('style','width:0');
		var fileNames = $('#upload-files').prop('files');
		iTaskid = $('#taskid').val();
		iProjectId = $('#projectid').val();
		count = 1;
		phpcount = 0;
		$('.uploadform .progress-group').removeClass('ninja');
		$('.uploadform .progress-number').html('0/'+fileNames.length);
		for (index = fileNames.length - 1; index >= 0; --index) {
			var data = new FormData();
			data.append('upload', $('#upload-files')[0].files[phpcount]);
			phpcount ++;
			data.append('cl', 'tasklist');
			data.append('fnc', 'uploadFiles');
			data.append('taskid', iTaskid);
			data.append('projectid', iProjectId);

			$.ajax({
				url: "index.php",
				data: data,
				cache: false,
				contentType: false,
				processData: false,
				type: 'POST'
			}).done(function() {
				uploadPercent = Math.round(count/fileNames.length*100);
				$('.uploadform .progress-number').html(count+'/'+fileNames.length);
				$('.uploadform .progress-bar').attr('style','width:'+uploadPercent+'%');
				if (uploadPercent == 100) {
					window.setTimeout(function(){window.location.reload()}, 1500);
				}
				count ++;
			});

			
		}
     });

	// Set Notification to Read
	$('body').on('click','.notifications-menu ul.menu li a', function(e) {
		e.preventDefault();
		sNotificationId = $(this).parent('li').attr('class');
		sMyLink = $(this).attr('href');
		INotificationId = sNotificationId.replace("notification-", "");

		var data = new FormData();
		data.append('cl', 'notification');
		data.append('fnc', 'setNotificationToRead');
		data.append('id', INotificationId);

		$.ajax({
			url: "index.php",
			data: data,
			cache: false,
			contentType: false,
			processData: false,
			type: 'POST'
		}).done(function() {
			window.location.replace(sMyLink);
		});

	});

	// Report
	// Set Function to generate Report
	$('body').on('click','#generateReport', function(e) {
		e.preventDefault();
		$(this).closest('form').children('.fnc').val('generateReport');
		$(this).closest('form').submit();
	});

});

function reSortWorkflows() {
	counter = 1;
	maxrows = $("#workflowsteps tr.datas").length;
	
	$("#workflowsteps tr.datas").each(function() {
		//myid = $(this).closest('form').children('input[name=awid]').val();
		myid = $(this).children('td').children('input[type=text]').attr('name');
		workflowStepId = myid.replace(/awname-(.*?)-sort(.+?)/g, "$1");

		appendhtml = '';
		
		$(this).children('td').children('input[type=text]').attr('name','awname-'+workflowStepId+'-sort'+counter);
		
		$(this).children('td').children(".btn-group").empty();
		if (counter != 1) {
			appendhtml = '<span class="btn btn-default btn-flat sortup"><i class="fa fa-arrow-up"></i></span>';
		}
		if (counter != maxrows) {
			appendhtml = appendhtml+'<span class="btn btn-default btn-flat sortdown"><i class="fa fa-arrow-down"></i></span>';
		}
		appendhtml = appendhtml+' <span class="btn btn-default btn-flat delstep"><i class="fa fa-minus"></i></span>';
		$(this).children('td').children(".btn-group").html(appendhtml);
		counter ++;
	});
}

function validateForm(formid) {
	validate = 0;
	$(formid+" .required").each(function() {
		if ($(this).val() == '' || $(this).val() == '00:00') {
			$(this).closest('.form-group').addClass('has-error');
			validate++;
		}
	});
	if (validate == 0) {
		$(formid+" .required").each(function() {
			$(this).closest('.form-group').removeClass('has-error');
		});
		return true;
	}
	return false;
}

function getWorklog() {
	projectid = $('#projectid').val();
	taskid = $('#taskid').val();
	$.ajax({
		url:"index.php",
		data: 'cl=worklog&fnc=getWorkLog&project='+projectid+'&task='+taskid,
		success:function(response) {
			$('#tab_2-2').html(response);
		}
	});
}

function getComments() {
	projectid = $('#projectid').val();
	taskid = $('#taskid').val();
	$.ajax({
		url:"index.php",
		data: 'cl=comments&fnc=getCommentsLog&project='+projectid+'&task='+taskid,
		success:function(response) {
			$('#tab_3-3').html(response);
		}
	});
}

function getHistory() {
	projectid = $('#projectid').val();
	taskid = $('#taskid').val();
	$.ajax({
		url:"index.php",
		data: 'cl=history&fnc=getHistory&project='+projectid+'&task='+taskid,
		success:function(response) {
			$('#tab_4-4').html(response);
		}
	});
}

function getCookie(c_name) {
    var i,x,y,ARRcookies = document.cookie.split(";");
    for (i = 0; i < ARRcookies.length; i++) {
        x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
        x = x.replace(/^\s+|\s+$/g, "");
        if (x == c_name) {
            return unescape(y);
        }
    }
}

function checkCookie(c_name) {
    var mycookie = getCookie(c_name);
    if (mycookie != null && mycookie != "") {
        return true;
    }
    else {
        return false;
    }
}

$(function initial() {
	$(".texteditor").wysihtml5();
	//Datemask yyyy/mm/dd
	$(".date").datepicker({
		format: 'yyyy-mm-dd',
		startDate: '-3d'
	});
	$(".datealltime").datepicker({
		format: 'yyyy-mm-dd',
		//startDate: '-3d'
	});
	//$(".date").inputmask("yyyy/mm/dd", {"placeholder": "yyyy/mm/dd"});
	//Timepicker
	$(".timepicker").timepicker({
	  showInputs: false,
	  showMeridian: false,
	  defaultTime: '00:00'
	});
	$(".multiselect").select2();

	var date = new Date();
	var d = date.getDate(),
		m = date.getMonth(),
		y = date.getFullYear();

});