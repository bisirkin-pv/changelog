<#ftl encoding="utf-8"/>
<#macro page>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset='utf-8'>
    <link rel="stylesheet" href="/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script src="/js/jquery-1.12.3.min.js"></script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">
                <i class="fa fa-th-list" aria-hidden="true" style="color:#bce8f1"></i>
            </a>
                <ul class="nav navbar-nav">
                    <#if current_page == "showlog">
                        <li class="active"><a href="/changelog/showlog">Просмотр</a></li>
                    <#else>
                        <li><a href="/changelog/show">Просмотр</a></li>
                    </#if>

                    <#if current_page == "add">
                        <li class="active"><a href="/changelog/addlog">Добавление</a></li>
                    <#else>
                        <li><a href="/changelog/addlog">Добавление</a></li>
                    </#if>
                </ul>
        </div>
        <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-o" aria-hidden="true"></i> ${user_name}<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Online <span class="badge">${users_online}</span></a></li>
            <li><a href="/logout">Выход</a></li>
          </ul>
        </li>
        </ul>
    </div>
  </div>
</nav>
<div class="container main-blok">
<#nested>
</div>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>
</#macro>

