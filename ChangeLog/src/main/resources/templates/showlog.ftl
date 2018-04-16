<#ftl encoding="utf-8"/>
<#import "base.ftl" as base>
<@base.page>
<h1>Changelog</h1>
    <div class="panel panel-warning" id="collapse_panel_find">
        <div class="panel-heading">
                <h4 class="panel-title">
                  <a data-toggle="collapse" data-parent="#collapse_group_main" href="#panel_find">
                        Фильтры
                  </a>
                </h4>
        </div>
        
            <div class="panel-body panel-collapse collapse in" id="panel_find">
            <form class="form-inline" id=js-form-filter>                
                <div class="input-group">
                    <input type="text" class="form-control" aria-label="" name="in_find_version" placeholder="Версия">
                    <div class="input-group-btn">
                      <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">like <span class="caret"></span></button>
                      <ul class="dropdown-menu dropdown-menu-right rb-filter-type">
                        <li data-type="contains"><label for="js-rb-version_contains"><input name="rb-version" id="js-rb-version_contains" type="radio" value="contains">содержит</label></li>
                        <li data-type="begin"><label for="js-rb-version_begin"><input name="rb-version" id="js-rb-version_begin" type="radio" value="begin">начинается</label></li>
                        <li data-type="end"><label for="js-rb-version_end"><input name="rb-version" id="js-rb-version_end" type="radio" value="end">заканчивается</label></li>
                        <li data-type="equals"><label for="js-rb-version_equal"><input name="rb-version" id="js-rb-version_equal" type="radio" value="equal" checked>равно</label></li>
                      </ul>
                    </div><!-- /btn-group -->
                  </div><!-- /input-group -->
                <div class="input-group">
                <div class="input-group">
                    <input type="text" class="form-control" aria-label="" name="in_find_issue" placeholder="Номер задачи">
                    <div class="input-group-btn">
                      <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">like <span class="caret"></span></button>
                      <ul class="dropdown-menu dropdown-menu-right rb-filter-type">
                        <li data-type="contains"><label for="js-rb-issue_contains"><input name="rb-issue" id="js-rb-issue_contains" type="radio" value="contains">contains</label></li>
                        <li data-type="begin"><label for="js-rb-issue_begin"><input name="rb-issue" id="js-rb-issue_begin" type="radio" value="begin">begin</label></li>
                        <li data-type="end"><label for="js-rb-issue_end"><input name="rb-issue" id="js-rb-issue_end" type="radio" value="end">end</label></li>
                        <li data-type="equals"><label for="js-rb-issue_equal"><input name="rb-issue" id="js-rb-issue_equal" type="radio" value="equal" checked>equal</label></li>
                      </ul>
                    </div><!-- /btn-group -->
                  </div><!-- /input-group -->
                <div class="input-group">
                    <input type="text" class="form-control" aria-label="" name="in_find_object" placeholder="Название объекта">
                    <div class="input-group-btn">
                      <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">like <span class="caret"></span></button>
                      <ul class="dropdown-menu dropdown-menu-right rb-filter-type">
                        <li data-type="contains"><label for="js-rb-object-name_contains"><input name="rb-object-name" id="js-rb-object-name_contains" type="radio" value="contains">contains</label></li>
                        <li data-type="begin"><label for="js-rb-object-name_begin"><input name="rb-object-name" id="js-rb-object-name_begin" type="radio" value="begin">begin</label></li>
                        <li data-type="end"><label for="js-rb-object-name_end"><input name="rb-object-name" id="js-rb-object-name_end" type="radio" value="end">end</label></li>
                        <li data-type="equals"><label for="js-rb-object-name_equal"><input name="rb-object-name" id="js-rb-object-name_equal" type="radio" value="equal" checked>equal</label></li>
                      </ul>
                    </div><!-- /btn-group -->
                  </div><!-- /input-group -->
                <button type="button" class="btn btn-default" id="js-btn-find"><i class="fa fa-search" aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default" id="js-btn-clear" title="Очистить всё, CNTR+Q"><i class="fa fa-eraser" aria-hidden="true"></i></button>

            </form>   
                    
            </div>                    
        </div>
    </div>

    <div id = "log_block">    
    </div>

<div class="modal fade" tabindex="-1" role="dialog" id ="editModalHeader">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Редактирование</h4>
        </div>
        <div class="modal-body">
        <form id="form_log_header" class="form-horizontal" role="form">
            <div class="form-group">
                    <label class="col-sm-2 control-label">LOG ID:</label>
                    <div class="col-sm-2">                                           
                            <input type="text" class="form-control" name="in_id" placeholder="#">
                    </div>
                    <label class="col-sm-2 control-label">Версия:</label>
                    <div class="col-sm-2">
                            <input type="text" class="form-control" name="in_version" placeholder="2.0.26.1">				
                    </div>
                    <label class="col-sm-2 control-label">Дата:</label>
                    <div class="col-sm-2">
                            <input type="date" class="form-control" name="in_date" placeholder="09.01.2018">
                    </div>
            </div>

            <div class="form-group">
                    <label class="col-sm-2 control-label">№ задачи:</label>
                    <div class="col-sm-2">
                            <input type="text" class="form-control" name="in_issue" placeholder="178956">
                    </div>
                    <label class="col-sm-2 control-label">URL задачи:</label>
                    <div class="col-sm-6">
                            <input type="text" class="form-control" name="in_url" placeholder="https://redmine.ru/issues/178956">
                    </div>
            </div>

            <div class="form-group">
                    <label class="col-sm-2 control-label">Описание:</label>
                    <div class="col-sm-10">
                            <input type="text" class="form-control" name="in_descr" placeholder="Описание">				
                    </div>
            </div>
            <div class="form-group">
                    <label class="col-sm-2 control-label">Комментарий:</label>
                    <div class="col-sm-10">
                            <input type="text" class="form-control" name="in_comment" placeholder="Комментарий">				
                    </div>
            </div>

            <div class="form-group">
                    <label class="col-sm-2 control-label">Разработчик(login):</label>
                    <div class="col-sm-4">
                            <input type="text" class="form-control" name="in_developer" id="in_developer" placeholder="bisirkin_pv">
                    </div>
                    <label class="col-sm-1 control-label">Commit:</label>
                    <div class="col-sm-2">
                            <input type="text" class="form-control" name="in_commit" placeholder="15689">
                    </div>
                    <label class="col-sm-1 control-label">Marge:</label>
                    <div class="col-sm-2">
                            <input type="text" class="form-control" name="in_copy_to" placeholder="10000">
                    </div>
            </div>
            <div class="form-group">
                    <div class="checkbox col-sm-offset-9 col-sm-1">
                        <label class="pull-right">
                            <input type="checkbox" id="in_chk_dev" name="in_chk_dev" value="1">Разработка
                        </label>                                        
                    </div>                   
            </div>
        </form>
        </div>
        <div class="modal-footer footer-relative">
                <span class="js-remove-log"><i class="fa fa-trash left-trash" aria-hidden="true"></i></span>
                <span id="change-result"></span>
                <button type="button" class="btn btn-default" data-dismiss="modal">Отменить</button>
                <button type="button" class="btn btn-success" id="js-btn-save-change">Сохранить</button>
        </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div style="display: none;" class="modal fade confirm-dialog" role="dialog" tabindex="-1" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-xs" role="document"> 
            <div class="modal-content"> 
                    <div class="modal-header"> 
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button> 
                    <h4 class="modal-title" id="mySmallModalLabel">Внимание</h4> 
                    </div> 
                    <div class="modal-body">  
                    <p>Вы действительно хотите удалить объект?</p>      
                    <p id="js-deleted-obj"><p>
                    <p id="js-deleted-info" data-index="" data-type=""><p>
                    </div> 
                    <div class="modal-footer footer-relative">
                            <button type="button" class="btn btn-primary" id="js-btn-delete-dismiss">Отменить</button>
                            <button type="button" class="btn btn-danger" id="js-btn-delete">Удалить</button>
                    </div>
            </div> 
    </div>
</div>

<div style="display: none;" class="modal fade add-detail-dialog" role="dialog" tabindex="-1" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-xs" role="document"> 
            <div class="modal-content"> 
                    <div class="modal-header"> 
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button> 
                    <h4 class="modal-title" id="mySmallModalLabel">Добавление</h4> 
                    </div> 
                    <div class="modal-body">  
                    <form role="form" id="form_log_detail">
                        <div class="form-group row">
                            <label class="col-sm-1 control-label">id:</label>
                            <div class="col-sm-1">
                                <p class="form-control-static" id="id_log"></p>
                            </div>
                            <input type="hidden" name="in_log_id" id="in_log_id">
                        </div>
                        <div class="form-group row">
                                <label class="col-sm-1 control-label">Объект:</label>
                                <div class="col-sm-4">
                                        <input type="text" class="form-control" name="in_object" id="in_object" placeholder="Объект">				
                                </div>							
                        </div>	                
                        <div class="form-group row">
                                <label class="col-sm-1 control-label">Описание:</label>
                                <div class="col-sm-9">
                                        <input type="date" class="form-control" name="in_obj_desc" id="in_obj_desc" placeholder="Описание">
                                </div>								
                                <div class="col-sm-2">
                                        <button type="button" class="btn btn-primary pull-right" id="btb_add_obj">Добавить</button>
                                </div>
                        </div>                        

                        </form>
                        <table class="table table-condensed table-striped" id="tbl_detail">
                                <thead>
                                        <tr>
                                                <th>Объект</th>
                                                <th>Описание</th>
                                        </tr>
                                </thead>
                                <tbody>

                                </tbody>
                        </table>
                    </div>      
                    <div class="modal-footer footer-relative">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Закрыть</button>
                    </div>               
            </div> 
    </div>
</div>

<script src="/js/showlog.js"></script>
</@base.page>