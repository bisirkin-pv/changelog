var filterObj = {}; /* глобавльный объект фильтра */
var isClear = true;


$(document).ready(function(){
    $(document).off('.modal.data-api');
    loadAjax('/api/header',function(json){
            showPanels(json);
    });
    //Событие отображения деталей, срабатывает один раз
    $("#log_block").on('click','.panel-heading',function(){
        var el = $(this).parent('.show-detail');
        var idEl = el.attr('id')
            ,idx = el.attr('data-index')
            ,$elForTbl = $("#"+idEl+" .tbl-detail")
            ,$elTbl = $elForTbl.find('table');
        if($elTbl.length===0){
            getDetailTable(idx,$elForTbl);                        
        }
    });  
    $("#log_block").on('click','.js-edit-header',function(){
        var $table = $(this).parent().parent().parent().parent();                
        popupDataFromTable($table);
        $('#change-result').html("");
        $('#editModalHeader').modal();              
    });  

    $('#js-btn-save-change').click(function(){
        $.ajax({
            url: '/api/header/upd',
            type: "POST",
            data: $('#form_log_header').serialize(),
            success: function(){
                $('#change-result').html("Обновление произведено успешно.").removeClass("redText").addClass("greenText");                
                $("#editModalHeader").modal('hide');
            },
            error: function(xhr, status, error) {
                    console.log(xhr.responseText);
                    console.log(error);
                    $('#change-result').html("В ходе обновления возникли ошибки.").removeClass("greenText").addClass("redText");

            }
	    });
    });
   $('#js-btn-find').click(function(){
       if($('#js-form-filter input[name=in_find_version]').val()===""
          && $('#js-form-filter input[name=in_find_issue]').val()===""
          && $('#js-form-filter input[name=in_find_object]').val()===""){
            clearFilter();
            return;
       }      
       getFilteredObjectId();
   });
   $('input[name=in_find_version]').keypress(function(event) {
	if(event.keyCode===13){
            $('#js-btn-find').click();          
        }
    });
    $('input[name=in_find_issue]').keypress(function(event) {
	if(event.keyCode===13){
            $('#js-btn-find').click();          
        }
    });
    $('input[name=in_find_object]').keypress(function(event) {
	if(event.keyCode===13){
            $('#js-btn-find').click();          
        }
    });
    $('#js-btn-clear').click(function(){
        $('#js-form-filter input[name=in_find_version]').val("");
        $('#js-form-filter input[name=in_find_issue]').val("");
        $('#js-form-filter input[name=in_find_object]').val("");
        clearFilter();        
    });
    /* Событие очистки на cntr+q */
    document.onkeydown = function(e) {
        e = e || window.event;
        if (e.ctrlKey  && e.keyCode === 81) {
          $('#js-btn-clear').click();
        }
        return true;
    };
    /* событие на редоктирование информации по изменненным объектам */
    $("#log_block").on('click','.js-edit-detail-obj',function(){
        var clickElem = $(this);
        clearResultUpdate();
        if($(clickElem).hasClass('active')){
            return;
        }
        var tr = $(this).parent().parent();
        var td = $(tr).find('td');
        var table = $(this).parent().parent().parent().parent();
        var clId = $(table).attr("data-header_id");
        /* проверяем не редактируется ли ячека */
        checkEditebled();        
        $(td[0]).addClass("changeble");
        $('.changeble').attr('contenteditable',"true");
        var contents = $('.changeble').html();
        var id = $(tr).attr("data-index");
        $(clickElem).addClass("active");
        var url = "/api/detail/upd";
        var typeUpd = "name";
        $('.changeble').blur(function(){
                if(contents!==$(this).html()){									
                        contents = $(this).html();
                        saveEditAnswer(id, contents,td[0], url, typeUpd,clId);
                }
                $('.changeble').attr('contenteditable',"false");
                $(td[0]).removeClass("changeble");
                $(clickElem).removeClass("active");
        });
        //contenteditable
    });
    
    $("#log_block").on('click','.js-edit-detail-desc',function(){
        var clickElem = $(this);
        clearResultUpdate();
        if($(clickElem).hasClass('active')){
            return;
        }
        var table = $(this).parent().parent().parent().parent();
        var clId = $(table).attr("data-header_id");
        var tr = $(this).parent().parent();
        var td = $(tr).find('td');        
        /* проверяем не редактируется ли ячека */
        checkEditebled();               
        $(td[2]).addClass("changeble");
        $('.changeble').attr('contenteditable',"true");
        var contents = $('.changeble').html();
        var id = $(tr).attr("data-index");
        $(clickElem).addClass("active");   
        var url = "/api/detail/upd";
        var typeUpd = "desc";
        $('.changeble').blur(function(){
                if(contents!==$(this).html()){									
                        contents = $(this).html();
                        saveEditAnswer(id, contents,td[2], url, typeUpd, clId);
                }
                $('.changeble').attr('contenteditable',"false");
                $(td[2]).removeClass("changeble");
                $(clickElem).removeClass("active");
        });
    });
    $("#log_block").on('click','.js-edit-delete',function(){
        var tr = $(this).parent().parent();
        var id = $(tr).attr("data-index");  
        var td = $(tr).find('td');
        $(tr).addClass("removed");
        $("#js-deleted-obj").html($(td[0]).html());
        $("#js-deleted-info").attr("data-index",id);
        $("#js-deleted-info").attr("data-type","detail");
        $(".confirm-dialog").modal();
    });
    
    $("#js-btn-delete").click(function(){
        var id = $("#js-deleted-info").attr("data-index");
        var type = $("#js-deleted-info").attr("data-type");
        removeObj(id, type);
        $(".confirm-dialog").modal('hide');        
    });
    $("#js-btn-delete-dismiss").click(function(){
        $(".removed").removeClass("removed");
        $(".confirm-dialog").modal('hide'); 
    });
    
    /* Удоляем лог */
    $(".modal-dialog").on('click','.js-remove-log',function(){
        var id = $("input[name=in_id]").val();
        $("#collapse_log_"+id).addClass("removed");
        $("#js-deleted-obj").html($("input[name=in_descr]").val());
        $("#js-deleted-info").attr("data-index",id);
        $("#js-deleted-info").attr("data-type","log");        
        $(".confirm-dialog").modal();
    });
    
    /* Добавление деталей */
    $("body").on('click','.js-add-detail-obj',function(){
        var table = $(this).parent().parent().parent().parent();
        $(table).find("tbody").append(createRowDetail("new",0,"",""));
    });
    //
});

function removeObj(id, type){
    $.ajax({
	  url: "/api/changelog/del",
          type: "post",
          data: { 
            'id': id,
            'type' : type
          },
	  success: function(status){  
            if(status==="OK"){
                $(".removed").remove();
                $('#editModalHeader').modal('hide');
                console.log("Объект удален");
            }else{
                $(".removed").removeClass("removed");
            }
	  },
          error: function(){
              $(".removed").removeClass("removed");
              console.log("Ошибка удаления");
          }
	});
    
}

/* сохраняет редактирование объекта */
function saveEditAnswer(id, contents,elem, url, typeUpd, clId){
    $.ajax({
	  url: url,
          type: "post",
          data: { 
            'id': id,
            'content' : contents,
            'type' : typeUpd,
            'clId' : clId
          },
	  success: function(status){                    
            if (status==="OK" || !isNaN(status)){
                if(!isNaN(status)){
                    $(elem).parent().attr("data-index",status);
                }
                $(elem).addClass("good-update");
            }else{
                $(elem).addClass("error-update");
            }
	  },
          error: function(e){
              $(elem).addClass("error-update");
          }
	});
}
/* проверяет нет ли уже редактируемых объектов*/
function checkEditebled(){
    var tdEdit = $(".changeble");    
    if(tdEdit.length>0){
        $('.changeble').blur();
    }
}
/* обирает классы результата обновления объекта */
function clearResultUpdate(){
    $(".good-update").removeClass("good-update");
    $(".error-update").removeClass("error-update");
}

//Загружаем данные
function loadAjax(url, collback){
    $.ajax({
        url: url,
        dataType: 'json',
        success: collback,
        error: function(){
            console.log("Error load");
        }
    });
}

function showPanels(json){
    var $block = $("#log_block");
    for(var i = 0; i<json.length; i++){
        $block.append(createPanel(json[i]));
    }    
}

//Строим заголовок панели с логом (Принимает объект tableHeader)
function createPanel(tableHeader){

    var crossIssue = tableHeader.crossIssue ? '<span><i class="fa fa-chain-broken" aria-hidden="true"> (' + tableHeader.crossIssue + ')</i></span>' : '';
    var classHeader = tableHeader.isDev === true ? "panel-info" : "panel-success";
    var html = '<div class="show-detail panel '+classHeader+'" id="collapse_log_'+tableHeader.id+'" data-index='+tableHeader.id+'>'
    +'<div class="panel-heading">'
    +        '<h4 class="panel-title">'
    +          '<a data-toggle="collapse" data-parent="#collapse_group_ref" href="#panel_body_ref_'+tableHeader.id+'"> Версия: ' + tableHeader.version
    + ' (' + tableHeader.issue + ') - ' + tableHeader.dt
    +          '</a>'
    +        '</h4>' 
    + crossIssue   
    +'</div>'
    +'<div class="panel-body panel-collapse collapse" id="panel_body_ref_'+tableHeader.id+'">'
    + createHeaderTable(tableHeader)
    +'<div class="tbl-detail"></div></div>'
    +'</div>';
    return html;
}
// Таблица основных сведений
function createHeaderTable(tableHeader){    
    var html = '<table class="table table-condensed table-striped" id="tbl_header_'+tableHeader.id+'" data-version="'+tableHeader.version+'" data-dev="'+tableHeader.isDev+'">'
               + '<thead><tr><th>Объект</th><th>Описание</th><th><span class="tbl-edit-icon js-unload-deploy"><i class="fa fa-cloud-download" aria-hidden="true"></i></span>'
               + '<span class="tbl-edit-icon js-edit-header" data-toggle="modal" data-target="#editModal"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></th></tr>'
               + '</thead><tbody>'
               + '<tr><td>ID LOG:</td><td colspan=2>'+tableHeader.id+'</td></tr>'
               + '<tr><td>Дата:</td><td colspan=2>'+tableHeader.dt+'</td></tr>'
               + '<tr><td>Статус:</td><td colspan=2><span class="label " id="js-tbl-issue-status_'+tableHeader.issue+'"><span></td></tr>'
               + '<tr><td>Задача:</td><td colspan=2><a href="'+tableHeader.issueUrl+'">'+tableHeader.issue+'</a></td></tr>'
               + '<tr><td>Описание:</td><td colspan=2>'+tableHeader.description+'</td></tr>'
               + '<tr><td>Комментарий:</td><td colspan=2>'+tableHeader.comment+'</td></tr>'
               + '<tr><td>Разработчик:</td><td colspan=2><span id="js-tbl-razrab_'+tableHeader.issue+'">'+tableHeader.fio+'</span></td></tr>'
               + '<tr><td>Commit:</td><td colspan=2>'+tableHeader.svnCommit+'</td></tr>'
               + '<tr><td>Merge commit:</td><td colspan=2>'+tableHeader.svnCopyTo+'</td></tr>'
               + '</tbody></table>';
    return html;
}

// таблица изменяемых объектов
function getDetailTable(id,elem){
    loadAjax('/api/detail/'+id,function(tableDetail){
        $(elem).append(createDetailTable(tableDetail, id));
    });
    
}

function createDetailTable(tableDetail,id){    
    var html = '<hr /><h4>Измененные объекты:</h4>'
                + '<table class="table table-condensed js-table-detail table-striped" id="tbl_detail_'+id+'" data-header_id = "'+id+'">'
                + '<thead><tr><th colspan="2">Объект</th><th colspan="2">Описание</th><th><span class="tbl-edit-icon-obj js-add-detail-obj"><i class="fa fa-plus" aria-hidden="true"></i></span></th></tr>'
                + '</thead><tbody>';
 for(var i=0;i<tableDetail.length;i++){  
                var successFilter = checkObjectInFilter(tableDetail[i].id);
                html += createRowDetail(successFilter,tableDetail[i].id,tableDetail[i].objName,tableDetail[i].description);
   }
   html += '</tbody></table>';
   return html;
}

/* Поднимаем данные из таблицы в модальное окно для редактировнаия */
function popupDataFromTable(sourceElement){
    $('input[name=in_version]').val(sourceElement.attr('data-version'));
    
    if(sourceElement.attr('data-dev')==='true'){        
        $('input[name=in_chk_dev]').prop('checked', true);
    }
    var tr = $(sourceElement).find('tr').get();
    $(tr).each(function(idx, valTD){
        var td = $(valTD).find('td').get();
        $(td).each(function(i, v){
            if(idx===1 && i===1){
                $('input[name=in_id]').val($(v).html());
            }
            if(idx===2 && i===1){
                $('input[name=in_date]').val($(v).html());
            }
            if(idx===4 && i===1){
                var link = $(v).find('a').get();
                $('input[name=in_issue]').val($(link).html());
                $('input[name=in_url]').val($(link).attr('href'));
            }
            if(idx===5 && i===1){
                $('input[name=in_descr]').val($(v).html());
            }
            if(idx===6 && i===1){
                $('input[name=in_comment]').val($(v).html());
            }
            if(idx===7 && i===1){
                $('input[name=in_developer]').val($(v).find("span").html());
            }
            if(idx===8 && i===1){
                $('input[name=in_commit]').val($(v).html());
            }
            if(idx===9 && i===1){                
                $('input[name=in_copy_to]').val($(v).html());
            }            
        });
    });
}

/* фильтруем объекты */
function getFilteredObjectId(){
    $.ajax({
        url: '/api/filter',
        type: "post",
        data: $('#js-form-filter').serialize(),
        success: function(json){
            console.log(json);
            setFilter(json);
        },
        error: function(){
            console.log("Error");
        }
	});
}

/* Отображаем только отфильтрованные объекты */
/* принимает json того что оставить*/
//TODO: Исправить работу фильтра
function setFilter(filter){
    filterObj = JSON.parse(filter);
    if(filterObj.length===0){
        $("#log_block").addClass("hidden");
    }else{
        $("#log_block").removeClass("hidden");
    }
    var panels = $("#log_block").find(".show-detail");
    //console.log(panels);
    //console.log(filterObj);
 
    /* проходимся по всем логам и если их нету в объекте фильтра скрыаем, перед этим сбрасываем старый фильтр */
    for (var i=0; i<panels.length; i++){ 
        var index = panels[i].getAttribute("data-index");
        var isVisible = false;
        for (var f=0; f<filterObj.length; f++){
            if(index == filterObj[f].clId){
                isVisible = true;                
                break;        
            }
        }
        var table = $(panels[i]).find(".js-table-detail");    
        /*в текущей панели подсвечиваем строки*/
        if(table.length>0){            
            var tr = $(table).find("tr");        
            for (var j=1; j<tr.length; j++){
                var rowId = tr[j].getAttribute("data-index");
                console.log(rowId);   
                for (var f=0; f<filterObj.length; f++){
                    if(rowId == filterObj[f].objectId && index == filterObj[f].clId){
                        $(tr[j]).addClass("success");      
                    }
                }  

            }  
        }
        if(!isVisible){
            $(panels[i]).addClass("hidden");
        }else{
            $(panels[i]).removeClass("hidden");
        }        
        
        
    }
    isClear = false;
}

/* проверка объекта на попадание в фильтр и возвращает CSS class */
function checkObjectInFilter(objId){
    var isVisible = false;
    if($('#js-form-filter input[name=in_find_object]').val() !== ""){
        for (var f=0; f<filterObj.length; f++){        
            if(objId == filterObj[f].objectId){
                isVisible = true;
                break;        
            }
        }  
    }
    return isVisible ? "success" : "";
}
/* очистка фильтра */
function clearFilter(){
    if(isClear){return;}
    $("#log_block").removeClass("hidden");
    var panels = $("#log_block").find(".show-detail");
    for (var i=0; i<panels.length; i++){ 
        $(panels[i]).removeClass("hidden");
        var table = $(panels[i]).find(".js-table-detail");
        
        if(table.length>0){            
            var tr = $(panels[i]).find("tr.success");
            for (var f=0; f<tr.length; f++){
                $(tr).removeClass("success");
            }  
        }
    }


    isClear = true;
}

/* возвращает html строки с деталями */
function createRowDetail(successFilter,id,objName,description){
    return '<tr class="'+successFilter+'" data-index="'+id+'"><td>'+objName+'</td>'
                +'<td><span class="tbl-edit-icon-obj js-edit-detail-obj"><i class="fa fa-pencil" aria-hidden="true"></i></span></td>'
                + '<td>'+description+'</td>'
                +'<td><span class="tbl-edit-icon-obj js-edit-detail-desc"><i class="fa fa-pencil" aria-hidden="true"></i></span></td>'
                +'<td><span class="tbl-edit-icon-obj color-red js-edit-delete"><i class="fa fa-trash" aria-hidden="true"></i></span></td>'
                +'</tr>';    
}