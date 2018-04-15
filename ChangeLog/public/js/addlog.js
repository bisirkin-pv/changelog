$("#in_chk_dev").click(function(){ 
   if($(this).is(':checked')){
       $('#collapse_group_main').removeClass('panel-success');
       $('#collapse_group_main').addClass('panel-info');
       $('#collapse_group_ref').removeClass('panel-success');
       $('#collapse_group_ref').addClass('panel-info');
        
   }else{
       $('#collapse_group_main').removeClass('panel-info');
       $('#collapse_group_main').addClass('panel-success');   
       $('#collapse_group_ref').removeClass('panel-info');
       $('#collapse_group_ref').addClass('panel-success');
   }   
});

$("#btn_save_log").click(function(){
   clearDetail();
   sendChangeLog();   
});

$("#btb_add_obj").click(function(){
    var id = $('#form_log_detail').find("#in_log_id").val();
    var $desc = $('#form_log_detail').find("#in_obj_desc");  
    var $name = $('#form_log_detail').find("#in_object");    
    if(id>0 && $desc.val()!=="" && $name.val()!==""){
        sendDetailLog(); 
    }    
});


function sendChangeLog(){	
	$.ajax({
	  url: '/api/header',
          type: "POST",
	  data: $('#form_log_header').serialize(),
	  success: function(logid){
		$("#id_log").html(logid);
                $("#in_log_id").val(logid);
		console.log(logid);
		
	  },
          error: function(e){
              console.log("Error, sendChangeLog");
          }
	});
};

 function sendDetailLog(){	
	$.ajax({
	  url: '/api/detail',
          type: "POST",
	  data: $('#form_log_detail').serialize(),
	  success: function(logid){
                var $desc = $('#form_log_detail').find("#in_obj_desc");  
                var $name = $('#form_log_detail').find("#in_object");       
                $('#tbl_detail > tbody').append('<tr><td>'+$name.val()+'</td><td>'+$desc.val()+'</td></tr>');	
                $desc.val("");
                $name.val("");
	  },
          error: function(e){
              console.log("Error, sendDetailLog");
          }
	});
};

function clearDetail(){
   console.log("clear");
   $('#form_log_detail').find("#in_log_id").val("");
   $('#form_log_detail').find("#in_obj_desc").val("");  
   $('#form_log_detail').find("#in_object").val(""); 
   $('#tbl_detail > tbody').html("");   
}


$(document).ready(function(){
   
    
    $('input[name=in_issue]').change(function(){
       var val = $(this).val();
       if(val !== ""){
           $('input[name=in_url]').val("https://redmine.ru/issues/"+val);
           getIssueInfo(val);
           /* получаем текущюю версию*/
           getCurrentVersion();
       }else
           $('input[name=in_url]').val("");           
    });

});

function getCurrentVersion(){
    $.ajax({
	  url: '/api/version',
          type: "POST",
	  success: function(ver){
                
                var $version = $('input[name=in_version]');
                $version.val(ver);
	  },
          error: function(e){
              console.log("Error, getCurrentVersion");
          }
	});
}
/* Получаем сведения из редмаина */
function getIssueInfo(id){
    $.ajax({
        url: '/api/issue',
        type: "POST",
        dataType: 'json',
        data: 'in_issue=' + id,
        success: function(json){
	    console.log(json);
            if(json.length>0){
                $("input[name=in_descr]").val(json[0].issueName);
                $("input[name=in_date]").val(json[0].endDevelopmentDt);
                $("input[name=in_developer]").val(json[0].login);
                $("input[name=in_comment]").select();
                $("#js-label-status").removeClass();
                var status = json[0].status;
                $("#js-label-status").addClass('label ' + getClassStatus(status));
                $("#js-label-status").html(status);
            }else{
                $("input[name=in_descr]").val("");
                $("input[name=in_date]").val("");
                $("input[name=in_developer]").val("");
                $("#js-label-status").removeClass();
                $("#js-label-status").addClass('label label-default');
                $("#js-label-status").html("Статус");
            }
	},
        error: function(e){
            console.log("Error, getIssueInfo");
        }
	});
}


/*
 *  Функция устанавливает класс для статуса
 *  in: Название статуса
 */
function getClassStatus(status){
    var styleClass = '';
    switch(status){
        case 'В ожидании внедрения':
        case 'В процессе внедрения':
        case 'Завершено внедрение':    
        case 'Завершено тестирование':
        case 'Завершена разработка':
        case 'Завершена разработка':
        case 'Выполнена':
            styleClass = ' label-success ';
            break;
        case 'Аудит кода разработки':
        case 'В ожидании тестирования':
        case 'В процессе тестирования':
            styleClass = ' label-info ';
            break;
        case 'В процессе разработки':
            styleClass = ' label-primary ';
            break;
        case 'В ожидании разработки':
            styleClass = ' label-warning ';
            break;
        case 'Отменена':
            styleClass = ' label-danger ';
            break;
        default:
            styleClass = ' label-default ';
            break;
    }
    return styleClass;
}