<#ftl encoding="utf-8"/>
<#import "base.ftl" as base>
<@base.page>
<div class="panel panel-success" id="collapse_group_main">
    <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#collapse_group_main" href="#panel_body_main">
                    Основные данные по поставке
              </a>
            </h4>
    </div>
            <div class="panel-body panel-collapse collapse in" id="panel_body_main">
                    <form id="form_log_header" class="form-horizontal" role="form">

                            <div class="form-group">                                                                        
                                    <label class="col-sm-2 control-label">Версия:</label>
                                    <div class="col-sm-2">
                                            <input type="text" class="form-control" name="in_version" placeholder="0.0.1">
                                    </div>
                                    <label class="col-sm-2 control-label">№ задачи:</label>
                                    <div class="col-sm-2">
                                            <input type="text" class="form-control" name="in_issue" placeholder="123456">
                                            <span class="find-wait"></span>
                                    </div>
                                    <div class="col-sm-2">
                                        <span class="label label-default" id="js-label-status">Статус</span>
                                    </div>
                            </div>

                            <div class="form-group">
                                    <label class="col-sm-2 control-label">Дата:</label>
                                    <div class="col-sm-2">
                                            <input type="date" class="form-control" name="in_date" placeholder="дд.мм.гггг">
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
                                    <div class="col-sm-2">
                                            <input type="text" class="form-control" name="in_developer" id="in_developer" placeholder="login" value="${user_login}">
                                    </div>
                                    <label class="col-sm-2 control-label">Commit:</label>
                                    <div class="col-sm-2">
                                            <input type="text" class="form-control" name="in_commit" placeholder="15689">
                                    </div>
                                    <label class="col-sm-2 control-label">Marge commit:</label>
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
                                    <div class="col-sm-2">
                                        <button type="button" class="btn btn-success pull-right" id="btn_save_log">Сохранить</button>
                                    </div>
                            </div>
                            
                    </form>
            </div>            
    </div>

<div class="panel panel-success" id="collapse_group_ref">
    <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#collapse_group_ref" href="#panel_body_ref">
                    Данные по измененным объектам
              </a>
            </h4>
    </div>
    <div class="panel-body panel-collapse collapse in" id="panel_body_ref">
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
                                <input type="text" class="form-control" name="in_obj_desc" id="in_obj_desc" placeholder="Описание">
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
</div>
<script src="/js/addlog.js"></script>
</@base.page>
